# domain name
 variable "my-domain" {
    description = "making my domain name a variable"
    default = "tripinky.com"
    type    = string
}

# vpc
# vpc cidr block
variable "vpc_cidr_block" {
    description = "making vpc_cidr_block a variable"
    default = "10.0.0.0/16"
    type    = string
}

variable "instance_tenancy" {
    description = "making vpc instance tenancy a variable"
    default = "default"
    type    = string
}

variable "enable_dns_hostnames" {
    description = "making vpc enable dns hostnames a variable"
    default = "true"
    type    = string
}

variable "enable_dns_support" {
    description = "making vpc enable dns support a variable"
    default = "true"
    type    = string
}

variable "vpc_name" {
    description = "making vpc_name a variable"
    default = "e-learning"
    type    = string
}


# alb

/* variable "alb-name" {
    description = "making alb-name a variable"
    default = "e-learning-alb"
    type    = string
} */
 
# application load balancer
variable "alb_name" {
    description = "making alb-name a variable"
    default = "e-learning-alb"
    type    = string
}

variable "alb_load_balancer_type" {
    description = "making alb_load_balancer_type a variable"
    default = "application"
    type    = string
}

variable "alb_enable_deletion_protection" {
    description = "making alb_enable_deletion_protection a variable"
    default = false
    type    = bool
}

 variable "alb_egress_cidr_block" {
    description = "making alb_egress_cidr_block a variable"
    default = ["0.0.0.0/0"]
    type    = list
}

 variable "alb_egress_from_port" {
    description = "making alb_egress_from_port a variable"
    default = 0
    type    = number
}

 variable "alb_egress_to_port" {
    description = "making alb_egress_to_port a variable"
    default = 0
    type    = number
}
 variable "alb_egress_protocol" {
    description = "making alb_egress_protocol a variable"
    default = "-1"
    type    = string
}

 variable "alb_http_ingress_from_port" {
    description = "making alb_http_ingress_from_port a variable"
    default = 80
    type    = number
}

 variable "alb_http_ingress_to_port" {
    description = "making alb_http_ingress_to_port a variable"
    default = 80
    type    = number
}

 variable "alb_http_ingress_protocol" {
    description = "making alb_http_ingress_protocol a variable"
    default = "TCP"
    type    = string
}

 variable "alb_http_ingress_cidr_block" {
    description = "making alb_http_ingress_cidr_block a variable"
    default = ["0.0.0.0/0"]
    type    = list
}

 variable "alb_https_ingress_from_port" {
    description = "making alb_https_ingress_from_port a variable"
    default = 443
    type    = number
}

 variable "alb_https_ingress_to_port" {
    description = "making alb_https_ingress_to_port a variable"
    default = 443
    type    = number
}

 variable "alb_https_ingress_protocol" {
    description = "making alb_https_ingress_protocol a variable"
    default = "TCP"
    type    = string
}

 variable "alb_https_ingress_cidr_block" {
    description = "making alb_https_ingress_cidr_block a variable"
    default = ["0.0.0.0/0"]
    type    = list
}

 variable "load_balancer_type" {
    description = "making load_balancer_type a variable"
    default = "application"
    type    = string
}

 variable "e-learning-alb-https-listener_port" {
    description = "making e-learning-alb-https-listener_port a variable"
    default = 443
    type    = number
}

 variable "e-learning-alb-https-listener_protocol" {
    description = "making e-learning-alb-https-listener_protocol a variable"
    default = "HTTPS"
    type    = string
}

 variable "SSL_policy" {
    description = "making SSL_policy a variable"
    default = "ELBSecurityPolicy-2016-08"
    type    = string
}

 variable "Environment" {
    description = "making Environment a variable"
    default = "production"
    type    = string
}

# task definition
variable "task_definition_cpu" {
    description = "making task_definition_cpu a variable"
    default = 1024
    type    = number
}

variable "task_definition_memory" {
    description = "making task_definition_memory a variable"
    default = 2048
    type    = number
}

# subnets (i have commented out the subnet names)
variable "e-learning-priv-sub1_cidr_block" {
    description = "making e-learning-priv-sub1_cidr_block a variable"
    default = "10.0.1.0/24"
    type    = string
}

variable "e-learning-priv-sub1_availability_zone" {
    description = "making e-learning-priv-sub1_availability_zone a variable"
    default = "eu-west-2a"
    type    = string
}

variable "e-learning-priv-sub2_cidr_block" {
    description = "making e-learning-priv-sub2_cidr_block a variable"
    default = "10.0.2.0/24"
    type    = string
}

variable "e-learning-priv-sub2_availability_zone" {
    description = "making e-learning-priv-sub2_availability_zone a variable"
    default = "eu-west-2b"
    type    = string
}

variable "e-learning-pub-sub1_cidr_block" {
    description = "making e-learning-pub-sub1_cidr_block a variable"
    default = "10.0.3.0/24"
    type    = string
}

variable "e-learning-pub-sub1_availability_zone" {
    description = "making e-learning-pub-sub1_availability_zone a variable"
    default = "eu-west-2a"
    type    = string
}


variable "e-learning-pub-sub2_cidr_block" {
    description = "making e-learning-pub-sub2_cidr_block a variable"
    default = "10.0.4.0/24"
    type    = string
}

variable "e-learning-pub-sub2_availability_zone" {
    description = "making e-learning-pub-sub2_availability_zone a variable"
    default = "eu-west-2b"
    type    = string
}


# ecs service
variable "ecs_desired_count" {
    description = "making ecs_desired_count a variable"
    default = 2
    type    = number
}

variable "ecs_service_name" {
    description = "making ecs_service_name a variable"
    default = "e-learning-service"
    type    = string
}

variable "ecs_deployment_minimum_healthy_percent" {
    description = "making ecs_deployment_minimum_healthy_percent a variable"
    default = 100
    type    = number
}

variable "ecs_deployment_maximum_percent" {
    description = "making ecs_deployment_maximum_percent a variable"
    default = 200
    type    = number
}

variable "ecs_launch_type" {
    description = "making ecs_launch_type a variable"
    default = "FARGATE"
    type    = string
}

variable "ecs_platform_version" {
    description = "making ecs_platform_version a variable"
    default = "LATEST"
    type    = string
}

variable "ecs_scheduling_strategy" {
    description = "making ecs_scheduling_strategy a variable"
    default = "REPLICA"
    type    = string
}

variable "ecs_load_balancer_container_name" {
    description = "making ecs_load_balancer_container_name a variable"
    default = "nginxelearning"
    type    = string
}

variable "ecs_load_balancer_container_port" {
    description = "making ecs_load_balancer_container_port a variable"
    default = 80
    type    = number
}

variable "ecs_autoscaling_max_capacity" {
    description = "making ecs_autoscaling_max_capacity a variable"
    default = 4
    type    = number
}

variable "ecs_autoscaling_min_capacity" {
    description = "making ecs_autoscaling_min_capacity a variable"
    default = 2
    type    = number
}

variable "ecs_tax_definition_operating_system_family" {
    description = "making ecs_tax_definition_operating_system_family a variable"
    default = "LINUX"
    type    = string
}

variable "ecs_tax_definition_cpu_architecture" {
    description = "making ecs_tax_definition_cpu_architecture a variable"
    default = "X86_64"
    type    = string
}


variable "ecs_appautoscaling_policy_name" {
    description = "making ecs_appautoscaling_policy_name a variable"
    default = "e-learning-autoscaling-policy"
    type    = string
}

variable "ecs_appautoscaling_policy_policy_type" {
    description = "making ecs_appautoscaling_policy_policy_type a variable"
    default = "TargetTrackingScaling"
    type    = string
}

variable "ecs_appautoscaling_policy_target_value" {
    description = "making ecs_appautoscaling_policy_target_value a variable"
    default = 70
    type    = number
}

# postgresql db variables
variable "identifier" {
    description = "making postgresql identifier a variable"
    default = "mydb"
    type    = string
}

variable "allocated_storage" {
    description = "making postgresql allocated storage a variable"
    default = 20
    type    = number
}

variable "storage_type" {
    description = "making postgresql storage_type a variable"
    default = "gp2"
    type    = string
}

variable "engine_version" {
    description = "making postgresql engine_version a variable"
    default = "13.7"
    type    = string
}

variable "instance_class" {
    description = "making postgresql instance_class a variable"
    default = "db.t3.micro"
    type    = string
}

variable "db_name" {
    description = "making postgresql db_name a variable"
    default = "elearningpostgresql"
    type    = string
}

variable "username" {
    description = "making postgresql username a variable"
    default = "wilon"
    type    = string
    sensitive = true
}

variable "password" {
    description = "making postgresql password a variable"
    default = "4Getmen0t"
    type    = string
    sensitive = true
}

variable "apply_immediately" {
    description = "making postgresql apply_immediately a variable"
    default = true
    type    = bool
}

variable "skip_final_snapshot" {
    description = "making postgresql skip_final_snapshot a variable"
    default = true
    type    = bool
}

 variable "db_egress_cidr_block" {
    description = "making db_egress_cidr_block a variable"
    default = ["0.0.0.0/0"]
    type    = list
}

 variable "db_ingress_from_port" {
    description = "making db_ingress_from_port a variable"
    default = 5432
    type    = number
}

variable "db_ingress_to_port" {
    description = "making db_ingress_to_port a variable"
    default = 5432
    type    = number
}

variable "db_ingress_protocol" {
    description = "making db_ingress_protocol a variable"
    default = "tcp"
    type    = string
}

variable "db_egress_from_port" {
    description = "making db_egress_from_port a variable"
    default = 0
    type    = number
}


variable "db_egress_to_port" {
    description = "making db_egress_to_port a variable"
    default = 0
    type    = number
}

variable "db_egress_protocol" {
    description = "making db_egress_protocol a variable"
    default = "-1"
    type    = string
}

variable "tags" {
  default     = "PROD"
  description = "Variable for Tag in different environmets"
}