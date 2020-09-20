#
# EKS Worker Nodes Resources
#  * IAM role allowing Kubernetes actions to access other AWS services
#  * EKS Node Group to launch worker nodes
#

resource "aws_iam_role" "tf-eks-node" {
  name = "terraform-eks-tf-eks-node"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}


resource "aws_iam_role_policy_attachment" "tf-eks-node-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = "${aws_iam_role.tf-eks-node.name}"
}

resource "aws_iam_role_policy_attachment" "tf-eks-node-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = "${aws_iam_role.tf-eks-node.name}"
}

resource "aws_iam_role_policy_attachment" "tf-eks-node-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = "${aws_iam_role.tf-eks-node.name}"
}

#Policy for cluster autoscaling in k8s
resource "aws_iam_role_policy_attachment" "tf-eks-node-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = "${aws_iam_role.tf-eks-node.name}"
}

resource "aws_eks_node_group" "node01" {
  cluster_name    = "${aws_eks_cluster.tf-eks-node.name}"+
  node_group_name = "eks-node"
  node_role_arn   = "${aws_iam_role.tf-eks-node.arn}"
  subnet_ids      = ["${var.subnet-pvt-02}"]
  disk_size       = "50"
  instance_types  = ["t2.xlarge"]
  labels  = {
              "app": "web",
            }
  remote_access   {
      ec2_ssh_key = "${var.key-pair}"
      source_security_group_ids = ["sg-0a3578487275eef39","sg-06f2b967d5f52b80e"]
  }

  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.tf-eks-node-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.tf-eks-node-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.tf-eks-node-AmazonEC2ContainerRegistryReadOnly,
    aws_iam_role_policy_attachment.tf-eks-node-AmazonEKSClusterPolicy,
    aws_eks_cluster.tf-eks-lbsdev,
  ]
}