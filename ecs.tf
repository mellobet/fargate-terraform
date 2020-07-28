resource "aws_ecs_cluster" "web-ecs-cluster" {
    name = var.ecs_cluster_name
}


resource "aws_ecs_task_definition" "web-app" {
    family                      = "web-app"
    network_mode                = "awsvpc"
    cpu                         = 256
    memory                      = 512
    requires_compatibilities    = ["FARGATE"]
    container_definitions       = file("task-definition/service.json")
    #task_role_arn               = var.execution_role_arn
    execution_role_arn          = var.execution_role_arn
}

resource "aws_ecs_service" "ecs_service" {
    name            = var.ecs_service_name
    task_definition = aws_ecs_task_definition.web-app.id
    desired_count   = var.desired_task_number
    cluster         = aws_ecs_cluster.web-ecs-cluster.id
    launch_type     = "FARGATE"

    # Required when Fargate(awsvpc).
    network_configuration {
        subnets = [aws_subnet.public_subnet_1.id]
        security_groups = [aws_security_group.ecs_security_group.id]
        assign_public_ip = true
    }
}
