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

    # # Load Balancer
    load_balancer {
        container_name      = "nginx"
        container_port      = 80
        target_group_arn    = aws_alb_target_group.ecs_app_target_group.arn
    }

}

# Create a Target Group (with default Health Checks)
resource "aws_alb_target_group" "ecs_app_target_group" {
    name        = "${var.ecs_service_name}-TG"
    port        = 80        # Req when using type="ip"
    protocol    = "HTTP"    # Req when using type="ip"
    vpc_id      = aws_vpc.tf-main-vpc.id
    target_type = "ip"      # awsvpc only allows "ip"
}


# Create ALB
resource "aws_alb" "ecs_cluster_alb" {
    name            = "${var.ecs_cluster_name}-ALB"
    internal        = false
    security_groups = [aws_security_group.ecs_security_group.id]
    subnets         = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]
}

# Create Listener