resource "google_compute_vpn_tunnel" "harperdb_gcp_aws" {
  name           = "harperdb-gcp-aws"
  ike_version    = "2"
  peer_ip = var.aws_vpn_ip
  shared_secret = var.gcp_aws_shared_secret
  local_traffic_selector = ["0.0.0.0/0"]
  remote_traffic_selector = ["0.0.0.0/0"]
  local_tunnel_ip = var.gcp_vpn_ip
  remote_tunnel_ip = var.aws_vpn_ip
  vpn_gateway = google_compute_vpn_gateway.harperdb_gcp.self_link
  target_vpn_gateway = var.aws_vpn_gateway_link
}

resource "aws_vpn_connection" "harperdb_gcp_aws" {
  type = "ipsec.1"
  static_routes_only = true
  customer_gateway_id = "${google_compute_global_address.harperdb_gcp.id}"
  vpn_gateway_id = "${aws_vpn_gateway.harperdb_aws.id}"
  ike_policy = "${data.template_file.gcp_aws_ike_policy.rendered}"
  ipsec_policy = "${data.template_file.gcp_aws_ipsec_policy.rendered}"
}

resource "azurerm_virtual_network_gateway_connection" "harperdb_azure_gcp" {
  name = "harperdb-azure-gcp"
  location = azurerm_resource_group.harperdb.location
  resource_group_name = azurerm_resource_group.harperdb.name
  virtual_network_gateway_id = azurerm_virtual_network_gateway.harperdb_azure.id
  peer_virtual_network_id = var.gcp_vpc_id
  shared_key = var.azure_gcp_shared_key
  connection_type = "IPsec"
}

resource "azurerm_virtual_network_gateway_connection" "harperdb_azure_aws" {
  name = "harperdb-azure-aws"
  location = azurerm_resource_group.harperdb.location
  resource_group_name = azurerm_resource_group.harperdb.name
  virtual_network_gateway_id =  azurerm_virtual_network_gateway.harperdb_azure.id
  peer_virtual_network_id = var.aws_vpc_id
  shared_key = var.azure_aws_shared_key
  connection_type = "IPsec"
}