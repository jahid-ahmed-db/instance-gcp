output resource_id {
  value       = google_compute_instance.vm.id
  description = "ID of DeFi Vision instance"
}

output instance_id {
  value       = google_compute_instance.vm.instance_id
  description = "Instance ID of DeFi Vision instance"
}

output public_ip {
  value       = google_compute_address.static.address
  description = "Public IP"
}