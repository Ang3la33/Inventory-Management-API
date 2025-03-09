resource "aws_apigatewayv2_api" "inventory_api" {
  name          = "InventoryAPI"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_stage" "inventory_stage" {
  api_id      = aws_apigatewayv2_api.inventory_api.id
  name        = "$default"
  auto_deploy = true
}

resource "aws_apigatewayv2_integration" "lambda_integration" {
  api_id           = aws_apigatewayv2_api.inventory_api.id
  integration_type = "AWS_PROXY"
  integration_uri  = aws_lambda_function.inventory_lambda.invoke_arn
}

resource "aws_apigatewayv2_route" "inventory_route" {
  api_id    = aws_apigatewayv2_api.inventory_api.id
  route_key = "ANY /{proxy+}"
  target    = "integrations/${aws_apigatewayv2_integration.lambda_integration.id}"
}
