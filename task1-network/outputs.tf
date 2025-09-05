# VPN Tunnel Details from Invictus to Member1
output "invictus_vpn_gateway_ip" {
  value = google_compute_address.invictus_vpn_ip.address
  description = "Public IP of Invictus VPN Gateway"
}

# Member 1 VP Gateway IP
output "member1_vpn_gateway_ip" {
  value = google_compute_address.member1_vpn_ip.address
  description = "Public IP of Member 1 VPN Gateway"
}

# VPC Peering Status 
output "member1_peering_status" {
  value = google_compute_network_peering.member1_to_member2.state
  description = "Status of VPC Peering between Member 1 and Member 2"
}

# Subnet CIDRS (for reference)
output "invictus_subnet" {
  value = google_compute_subnetwork.invictus_subnet.ip_cidr_range
  description = "Invictus subnet CIDR"
}

output "member1_subnet" {
  value = google_compute_subnetwork.member1_subnet.ip_cidr_range
  description = "Member 1's subnet CIDR"
}