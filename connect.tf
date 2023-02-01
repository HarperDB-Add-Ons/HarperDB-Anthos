# Anthos
resource "null_resource" "configure_kubeconfig" {
  provisioner "local-exec" {
    command = "gcloud container clusters get-credentials ${google_container_cluster.management_cluster.name} --zone ${google_container_cluster.management_cluster.zone} --project ${var.gcp_project}"
  }
}

# Azure
resource "null_resource" "join_aks_cluster" {
  provisioner "local-exec" {
    command = "kubefed join aks-cluster --host-cluster-context=management-cluster-context --cluster-context=aks-context --v=5"
  }
}

# AWS
resource "null_resource" "join_eks_cluster" {
  provisioner "local-exec" {
    command = "kubefed join eks-cluster --host-cluster-context=management-cluster-context --cluster-context=eks-context --v=5"
  }
}