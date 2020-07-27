variable "region" {
    default = "us-east-1"
}

variable "ecs_cluster_name" {
    default = "ezr-tf-ecs-cluster"
}

variable "vpc_cidr" {
    default = "10.1.0.0/16"
}

variable "public_subnet1_cidr" {
    default = "10.1.0.0/24"
}

variable "availability_zone" {
    default = "us-east-1a"
}

variable "internet_cidr_blocks" {
    default = "0.0.0.0/0"
}

variable "execution_role_arn" {
    default = "arn:aws:iam::005373091483:role/ecsTaskExecutionRole"
}

variable "ecs_service_name" {
    default = "ezr-svc"
}

variable "desired_task_number" {
    default = 1
}

variable "environment_tag" {
  description = "Environment tag"
  default = "development"
}
