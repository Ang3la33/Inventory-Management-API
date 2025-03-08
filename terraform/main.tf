provider "aws" {
  region = "us-east-1"
}

resource "aws_iam_role" "lambda_role" {
  name = "lambda_execution_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_policy_attachment" "lambda_basic_execution" {
  name       = "lambda_basic_execution"
  roles      = [aws_iam_role.lambda_role.name]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_function" "inventory_lambda" {
  function_name = "InventoryFunction"
  role          = aws_iam_role.lambda_role.arn
  runtime       = "python3.12"
  handler       = "lambda_function.lambda_handler"
  filename      = "lambda_function.zip"

  environment {
    variables = {
      TABLE_NAME = "InventoryTable"
    }
  }
}

output "api_gateway_invoke_url" {
  value       = aws_apigatewayv2_api.inventory_api.api_endpoint
  description = "The invoke URL for the API Gateway"
}
