# The VPN Tunnel
resource "google_compute_vpn_tunnel" "invictus_to_member1" {
  name = "invictus-to-member1"
  peer_ip = google_compute_address.member1_vpn_ip.address
  shared_secret = var.vpn_shared_secret
  target_vpn_gateway = google_compute_vpn_gateway.invictus_gateway.id

  local_traffic_selector = [var.invictus_subnet_cidr]
  remote_traffic_selector = [var.member1_subnet_cidr]

  depends_on = [
    google_compute_forwarding_rule.invictus_esp,
    google_compute_forwarding_rule.invictus_udp500,
    google_compute_forwarding_rule.invictus_udp4500
  ]
}

#The Compute Route for Invictus to Member1
resource "google_compute_route" "route_to_member1" {
  name = "route-to-member1"
  network = google_compute_network.invictus_vpc.id
  dest_range = var.member1_subnet_cidr
  next_hop_vpn_tunnel = google_compute_vpn_tunnel.invictus_to_member1.id
}


# The VPN Tunnel
resource "google_compute_vpn_tunnel" "invictus_to_member2" {
  name = "invictus-to-member2"
  peer_ip = google_compute_address.member2_vpn_ip.address
  shared_secret = var.vpn_shared_secret
  target_vpn_gateway = google_compute_vpn_gateway.invictus_gateway.id

  local_traffic_selector = [var.invictus_subnet_cidr]
  remote_traffic_selector = [var.member2_subnet_cidr]

  depends_on = [
    google_compute_forwarding_rule.invictus_esp,
    google_compute_forwarding_rule.invictus_udp500,
    google_compute_forwarding_rule.invictus_udp4500
  ]
}

#The Compute Route for Invictus to Member2
resource "google_compute_route" "route_to_member2" {
  name = "route-to-member2"
  network = google_compute_network.invictus_vpc.id
  dest_range = var.member2_subnet_cidr
  next_hop_vpn_tunnel = google_compute_vpn_tunnel.invictus_to_member2.id
}