#!/usr/bin/env ruby
# frozen_string_literal: true

require 'json'

ARSYS_PATH       = File.expand_path('..', __dir__)
DATACENTERS_PATH = File.join(ARSYS_PATH, 'terraform', 'data', 'datacenters.json')
VALIDATORS_PATH  = File.join(ARSYS_PATH, 'terraform', 'validators.tf')
START_MARKER     = '            # BEGIN GENERATED DATACENTERS'
END_MARKER       = '            # END GENERATED DATACENTERS'

datacenters = JSON.parse(File.read(DATACENTERS_PATH))
aliases     = datacenters.keys.sort.map(&:dump).join(', ')
generated   = [START_MARKER, "            values = [#{aliases}]", END_MARKER].join("\n")
validators  = File.read(VALIDATORS_PATH)
pattern     = /#{Regexp.escape(START_MARKER)}.*?#{Regexp.escape(END_MARKER)}/m

raise 'Generated datacenter markers not found in validators.tf' unless validators.match?(pattern)

expected = validators.sub(pattern, generated)

if ARGV == ['--check']
  abort 'validators.tf is not synchronized with datacenters.json' unless validators == expected

  exit
end

abort 'Usage: generate_datacenter_validators.rb [--check]' unless ARGV.empty?

File.write(VALIDATORS_PATH, expected)
