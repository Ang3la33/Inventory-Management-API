provider "aws" {
  region = "us-east-1"
}

resource "aws_iam_policy_attachment" "lambda_basic_execution" {
  name       = "lambda_basic_execution"
  roles      = [aws_iam_role.lambda_role.name]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# Output the API Gateway URL
output "api_gateway_invoke_url" {
  value       = aws_apigatewayv2_api.inventory_api.api_endpoint
  description = "The invoke URL for the API Gateway"
}
