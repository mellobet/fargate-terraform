resource "aws_ecs_cluster" "ezr-ecs-cluster" {
    name = var.ecs_cluster_name
}


resource "aws_ecs_task_definition" "ezr-app" {
    family                      = "ezr-app"
    network_mode                = "awsvpc"
    cpu                         = 256
    memory                      = 512
    requires_compatibilities    = ["FARGATE"]
    container_definitions       = file("task-definition/service.json")
    # task_role_arn               = 
    execution_role_arn          = var.execution_role_arn
}
