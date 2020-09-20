variable "cluster-name" {
  default = "terraform-eks-cluster"
  type    = string
}

variable "vpc_id" {
  default = "vpc-05e88fcf6f2896ec3"
}

variable "subnet-pub-01" {
  default = "subnet-084951afc30a9c918"
}

variable "subnet-pub-02" {
  default = "subnet-012c64f8ff9671ab7"
}

variable "subnet-pvt-01" {
  default = "subnet-019a337c1d067cb9d"
}

variable "subnet-pvt-02" {
  default = "subnet-03c702bb0aad8071e"
}

variable "key-pair" {
  default = "webapp"
}