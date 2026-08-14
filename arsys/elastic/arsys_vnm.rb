# -------------------------------------------------------------------------- #
# Copyright 2002-2025, OpenNebula Project, OpenNebula Systems                #
#                                                                            #
# Licensed under the Apache License, Version 2.0 (the "License"); you may    #
# not use this file except in compliance with the License. You may obtain    #
# a copy of the License at                                                   #
#                                                                            #
# http://www.apache.org/licenses/LICENSE-2.0                                 #
#                                                                            #
# Unless required by applicable law or agreed to in writing, software        #
# distributed under the License is distributed on an "AS IS" BASIS,          #
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.   #
# See the License for the specific language governing permissions and        #
# limitations under the License.                                             #
#--------------------------------------------------------------------------- #
#
ONE_LOCATION = ENV['ONE_LOCATION'] unless defined?(ONE_LOCATION)

if !ONE_LOCATION
    LIB_LOCATION      ||= '/usr/lib/one'
    RUBY_LIB_LOCATION ||= '/usr/lib/one/ruby'
    GEMS_LOCATION     ||= '/usr/share/one/gems'
    ARSYS_LOCATION    ||= '/usr/lib/one/ruby/vendors/arsys/lib'
else
    LIB_LOCATION      ||= ONE_LOCATION + '/lib'
    RUBY_LIB_LOCATION ||= ONE_LOCATION + '/lib/ruby'
    GEMS_LOCATION     ||= ONE_LOCATION + '/share/gems'
    ARSYS_LOCATION    ||= ONE_LOCATION + '/lib/ruby/vendors/arsys/lib'
end

# %%RUBYGEMS_SETUP_BEGIN%%
require 'load_opennebula_paths'
# %%RUBYGEMS_SETUP_END%%

$LOAD_PATH << RUBY_LIB_LOCATION
$LOAD_PATH << ARSYS_LOCATION

require 'net/http'
require 'uri'
require 'json'
require 'arsys'

# Class covering Arsys Baremetal functionality for the Elastic driver
class ArsysProvider < GenericProvider

    def initialize(provider, host)
        super(provider, host)
        @arsys = Arsys.new(@connection[:token], @connection[:host])
    end

    def assign(_ip, external, _opts = {})
        public_ip = arsys_public_ip(external)

        unless public_ip
            STDERR.puts "Error assigning #{external}: IP not found"
            return 1
        end

        return 0 if public_ip['assigned_to'] && public_ip['assigned_to']['id'] == @resource_id

        resp = @arsys.api_call(
            "/servers/#{@resource_id}/ips",
            Net::HTTP::Post,
            { 'id_ip' => public_ip['id'] }
        )

        unless ['200', '202', '409'].include?(resp.code)
            STDERR.puts "Error assigning #{external}: #{resp.message}"
            return 1
        end

        return 0
    rescue StandardError => e
        OpenNebula::DriverLogger.log_error("Error assigning #{external}: #{e.message}")
        1
    end

    def unassign(_ip, external, _opts = {})
        public_ip = arsys_public_ip(external)

        unless public_ip
            STDERR.puts "Error unassigning #{external}: IP not found"
            return 0
        end

        unless public_ip['assigned_to'] && public_ip['assigned_to']['id'] == @resource_id
            return 0
        end

        resp = @arsys.api_call(
            "/servers/#{@resource_id}/ips/#{public_ip['id']}",
            Net::HTTP::Delete
        )

        unless ['200', '202', '204', '409'].include?(resp.code)
            STDERR.puts "Error unassigning #{external}: #{resp.message}"
            return 1
        end

        return 0
    rescue StandardError => e
        OpenNebula::DriverLogger.log_error("Error unassigning #{external}: #{e.message}")
        1
    end

    def activate(cmds, nic)
        cmds.add :iptables,
                 "-t nat -A POSTROUTING -s #{nic[:ip]} -j SNAT " \
                 "--to-source #{nic[:external_ip]}"
        cmds.add :iptables,
                 "-t nat -A PREROUTING -d #{nic[:external_ip]} -j DNAT " \
                 "--to-destination #{nic[:ip]}"
    end

    def deactivate(cmds, nic)
        cmds.add :iptables,
                 "-t nat -D POSTROUTING -s #{nic[:ip]} -j SNAT " \
                 "--to-source #{nic[:external_ip]}"
        cmds.add :iptables,
                 "-t nat -D PREROUTING -d #{nic[:external_ip]} -j DNAT " \
                 "--to-destination #{nic[:ip]}"
    end

    private

    def arsys_public_ip(external_ip)
        response = @arsys.api_call('/public_ips')
        return unless response&.body

        public_ips = JSON.parse(response.body)
        public_ips.find {|ip| ip['ip'] == external_ip }
    end

end
