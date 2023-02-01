resource "google_container_cluster" "harperdb_cluster" {
  name     = "harperdb-cluster"
  location = var.gcp_region
}

resource "null_resource" "install_harperdb_helm_chart" {
  depends_on = [google_container_cluster.harperdb_cluster]

  provisioner "local-exec" {
    command = "kubectl create namespace harperdb && helm install my-harperdb harperdb/harperdb --namespace harperdb"
  }
}

