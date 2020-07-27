resource "aws_ecs_cluster" "ezr-ecs-cluter" {
    name = var.ecs_cluster_name
}