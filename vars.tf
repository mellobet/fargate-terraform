variable "region" {
    default = "us-east-1"
}

variable "ecs_cluster_name" {
    default = "ezr-tf-ecs-cluster"
}

variable "vpc_cidr" {
    default = "10.1.0.0/16"
}