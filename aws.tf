resource "aws_eks_cluster" "harperdb_cluster" {
  name     = "harperdb-cluster"
  role_arn = aws_iam_role.eks_cluster_role.arn
}

resource "null_resource" "install_harperdb_helm_chart" {
  depends_on = [aws_eks_cluster.harperdb_cluster]

  provisioner "local-exec" {
    command = "kubectl create namespace harperdb && helm install my-harperdb harperdb/harperdb --namespace harperdb"
  }
}