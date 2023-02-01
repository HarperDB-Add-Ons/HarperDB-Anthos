resource "azurerm_kubernetes_cluster" "harperdb_cluster" {
  name                = "harperdb-cluster"
  location            = var.azure_region
  resource_group_name = var.azure_resource_group
}

resource "null_resource" "install_harperdb_helm_chart" {
  depends_on = [azurerm_kubernetes_cluster.harperdb_cluster]

  provisioner "local-exec" {
    command = "kubectl create namespace harperdb && helm install my-harperdb harperdb/harperdb --namespace harperdb"
  }
}