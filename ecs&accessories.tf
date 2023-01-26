# ecs security group
resource "aws_security_group" "e-learning-ecs-sg" {
  name        = "e-learning-ecs-sg"
  description = "Allow TCP inbound traffic"
  vpc_id      = aws_vpc.e-learning.id

  ingress {
    description      = "TCP from alb"
    from_port        = 80
    to_port          = 80
    protocol         = "TCP"
    security_groups  = [aws_security_group.e-learning-alb-sg.id]
    
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    # ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = "e-learning-ecs-sg"
  }
}

# ecs cluster
resource "aws_ecs_cluster" "e-learning-cluster" {
  name = "e-learning-cluster"
}

# task definition
resource "aws_ecs_task_definition" "e-learning-task-definition" {
  family                   = "e-learning-task-definition"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.task_definition_cpu
  memory                   = var.task_definition_memory
  task_role_arn            = aws_iam_role.ecs_task_role.arn
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  container_definitions    = <<TASK_DEFINITION
[
  {
    "name": "nginxelearning",
    "image": "492367642859.dkr.ecr.eu-west-2.amazonaws.com/finalrepo:latest",
    "cpu": 1024,
    "memory": 2048,
     "portMappings":[
        {
          "name":"nginxelearning-80-tcp",  
          "containerPort":80,
          "hostPort":80,
          "protocol":"tcp",
          "appProtocol":"http"
        }
    ],
    "essential": true
  }
]
TASK_DEFINITION

  runtime_platform {
    operating_system_family = var.ecs_tax_definition_operating_system_family
    cpu_architecture        = var.ecs_tax_definition_cpu_architecture
  }
}

# task definition
#Creating ECS Service to Run Tasks
resource "aws_ecs_service" "e-learning-service" {
 name                               = var.ecs_service_name
 cluster                            = aws_ecs_cluster.e-learning-cluster.id
 task_definition                    = aws_ecs_task_definition.e-learning-task-definition.arn
 desired_count                      = var.ecs_desired_count
 deployment_minimum_healthy_percent = var.ecs_deployment_minimum_healthy_percent
 deployment_maximum_percent         = var.ecs_deployment_maximum_percent
 launch_type                        = var.ecs_launch_type
 platform_version                   = var.ecs_platform_version
 scheduling_strategy                = var.ecs_scheduling_strategy
  
 network_configuration {
   security_groups  = [aws_security_group.e-learning-ecs-sg.id]
   subnets          = [aws_subnet.e-learning-priv-sub1.id, aws_subnet.e-learning-priv-sub2.id]
   assign_public_ip = false
 }

 load_balancer {   
   target_group_arn = aws_lb_target_group.e-learning-alb-tg.arn
   container_name   = var.ecs_load_balancer_container_name
   container_port   = var.ecs_load_balancer_container_port
 }
 
 lifecycle {
   ignore_changes = [task_definition, desired_count]
 }
}

#Autoscaling for the Service
resource "aws_appautoscaling_target" "e-learning-autoscale" {
  max_capacity       = var.ecs_autoscaling_max_capacity
  min_capacity       = var.ecs_autoscaling_min_capacity
  resource_id        = "service/${aws_ecs_cluster.e-learning-cluster.name}/${aws_ecs_service.e-learning-service.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

#Auotscaling policy
resource "aws_appautoscaling_policy" "e-learning-autoscaling-policy" {
  name               = var.ecs_appautoscaling_policy_name
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.e-learning-autoscale.resource_id
  scalable_dimension = aws_appautoscaling_target.e-learning-autoscale.scalable_dimension
  service_namespace  = aws_appautoscaling_target.e-learning-autoscale.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }

    target_value = 70
  }
}