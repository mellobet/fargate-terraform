variable "region" {}

variable "ecs_cluster_name" {
    default = "web-tf-ecs-cluster"
}

variable "vpc_cidr" {
    default = "10.1.0.0/16"
}

variable "public_subnet1_cidr" {
    default = "10.1.0.0/24"
}

variable "public_subnet2_cidr" {
    default = "10.1.1.0/24"
}

variable "availability_zone_ps1" {}
variable "availability_zone_ps2" {}


variable "internet_cidr_blocks" {
    default = "0.0.0.0/0"
}

variable "execution_role_arn" {}

variable "ecs_service_name" {
    default = "web-svc"
}

variable "desired_task_number" {}
variable "environment_tag" {}
variable "task_cpu" {}
variable "task_mem" {}
