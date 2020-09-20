#
# EKS Cluster Resources
#  * IAM Role to allow EKS service to manage other AWS services
#  * EC2 Security Group to allow networking traffic with EKS cluster
#  * EKS Cluster
#

resource "aws_iam_role" "tf-eks-cluster" {
  name = "terraform-eks-tf-eks-cluster"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "tf-eks-cluster-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = "${aws_iam_role.tf-eks-cluster.name}"
}

resource "aws_iam_role_policy_attachment" "tf-eks-cluster-AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = "${aws_iam_role.tf-eks-cluster.name}"
}

resource "aws_eks_cluster" "tf-eks-cluster" {
  name     = "${var.cluster-name}"
  role_arn = "${aws_iam_role.tf-eks-cluster.arn}"

  vpc_config {
    security_group_ids = ["${aws_security_group.tf-eks-cluster.id}"]
    subnet_ids      = ["${var.subnet-pub-01}","${var.subnet-pub-02}","${var.subnet-pvt-01}","${var.subnet-pvt-02}"]
  }

  depends_on = [
    aws_iam_role_policy_attachment.tf-eks-cluster-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.tf-eks-cluster-AmazonEKSServicePolicy,
  ]
}