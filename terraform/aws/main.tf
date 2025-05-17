terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = var.region
}

data "aws_iam_policy_document" "ecs_task_exec" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "task_execution" {
  name               = "ecsTaskExecutionRole"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_exec.json
}

resource "aws_ecs_cluster" "hello" {
  name = "hello-cluster"
}

resource "aws_security_group" "allow_http" {
  name        = "allow_http"
  description = "Allow HTTP inbound on port 3000"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_ecs_task_definition" "hello" {
  family                   = "hello"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.task_execution.arn

  container_definitions = jsonencode([
    {
      name      = "hello"
      image     = var.image
      essential = true

      portMappings = [
        {
          containerPort = 3000
          hostPort      = 3000
          protocol      = "tcp"
        }
      ]

      # optional: send logs to CloudWatch
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.ecs_hello.name
          awslogs-region        = var.region
          awslogs-stream-prefix = "hello"
        }
      }

      # optional: inject New Relic APM env vars
      environment = [
        { name = "NEW_RELIC_LICENSE_KEY", value = var.new_relic_license_key },
        { name = "NEW_RELIC_APP_NAME",     value = "node-hello" }
      ]
    }

    # optional sidecar for Infra metrics
    ,{
      name      = "newrelic-infra"
      image     = "newrelic/infrastructure:latest"
      essential = false
      environment = [
        { name = "NRIA_LICENSE_KEY", value = var.new_relic_license_key },
        { name = "NRIA_DISPLAY_NAME",  value = "hello-cluster-agent" }
      ]
    }
  ])
}

resource "aws_ecs_service" "hello" {
  name            = "hello-service"
  cluster         = aws_ecs_cluster.hello.id
  task_definition = aws_ecs_task_definition.hello.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = var.subnets
    security_groups = [aws_security_group.allow_http.id]
    assign_public_ip = true
  }

  depends_on = [aws_iam_role.task_execution]
}
resource "aws_cloudwatch_log_group" "ecs_hello" {
  name              = "/ecs/hello"
  retention_in_days = 7
}
