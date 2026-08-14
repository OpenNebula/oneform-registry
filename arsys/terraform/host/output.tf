output "id" {
    value = [for instance in arsys-baremetal_server.host : instance.id]
}

output "public_ip" {
    value = [for s in arsys-baremetal_server.host : [for ip in s.ips : ip.ip if ip.main][0]]
}
