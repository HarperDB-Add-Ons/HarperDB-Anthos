resource "google_container_cluster" "management_cluster" {
  name     = "management-cluster"
  location = var.gcp_region
  initial_node_count = var.gcp_node_count
}

resource "google_container_cluster_addon" "config_management" {
  cluster = google_container_cluster.management_cluster.name
  config_management {
    enabled = true
  }
}