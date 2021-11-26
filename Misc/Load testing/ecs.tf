
# Cluster -------------------------------------------------

resource "aws_ecs_cluster" "my_cluster" {
  name = "my-cluster" # Naming the cluster
}

# Task -------------------------------------------------

resource "aws_ecs_task_definition" "my_first_task" {
  family                = "my-first-task" # Naming our first task
  container_definitions = <<DEFINITION
  [
    {
      "name": "my-first-task",
      "image": "${aws_ecr_repository.example.repository_url}",
      "essential": true,
      "memory": 512,
      "cpu": 2
    }
  ]
  DEFINITION
  execution_role_arn    = aws_iam_role.ecsTaskExecutionRole.arn
}

resource "aws_iam_role" "ecsTaskExecutionRole" {
  name               = "ecsTaskExecutionRole"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "ecsTaskExecutionRole_policy" {
  role       = aws_iam_role.ecsTaskExecutionRole.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# Service -------------------------------------------------

resource "aws_ecs_service" "my_first_service" {
  name            = "my-first-service"                        # Naming our first service
  cluster         = aws_ecs_cluster.my_cluster.id             # Referencing our created Cluster
  task_definition = aws_ecs_task_definition.my_first_task.arn # Referencing the task our service will spin up
  #   launch_type     = "FARGATE"
  desired_count = 1 # Setting the number of containers we want deployed to 3

  #   network_configuration {
  #     subnets = ["${aws_default_subnet.default_subnet_a.id}", "${aws_default_subnet.default_subnet_b.id}"]
  #   }
}


