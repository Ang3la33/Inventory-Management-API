resource "aws_apigatewayv2_api" "inventory_api" {
    name           = "InventoryAPI"
    protocol_type  = "HTTP" 
}

resource "aws_apigatewayv2_stage" "inventory_stage" {
    api_id      = aws_apigatewayv2_api.inventory_api.id 
    name        = "$default"
    auto_deploy = true  # Fixed typo
}

resource "aws_apigatewayv2_integration" "lambda_integration" {
    api_id            = aws_apigatewayv2_api.inventory_api.id 
    integration_type  = "AWS_PROXY"  # Fixed missing closing quote
    integration_uri   = aws_lambda_function.inventory_lambda.invoke_arn
}

resource "aws_apigatewayv2_route" "inventory_route" {
    api_id     = aws_apigatewayv2_api.inventory_api.id 
    route_key  = "ANY /{proxy+}"
    target     = "integrations/${aws_apigatewayv2_integration.lambda_integration.id}"
}

# CORS Preflight Handling
resource "aws_apigatewayv2_integration" "cors_mock" {
    api_id           = aws_apigatewayv2_api.inventory_api.id
    integration_type = "MOCK"
}

resource "aws_apigatewayv2_route" "cors_preflight" {
    api_id    = aws_apigatewayv2_api.inventory_api.id 
    route_key = "OPTIONS /{proxy+}"
    target    = "integrations/${aws_apigatewayv2_integration.cors_mock.id}"  # Fixed typo
}

resource "aws_apigatewayv2_route_response" "cors_response" {
    api_id     = aws_apigatewayv2_api.inventory_api.id 
    route_id   = aws_apigatewayv2_route.cors_preflight.id 
    route_key  = "OPTIONS /{proxy+}"
    model_selection_expression = "$default"

    response_parameters = {
        "Access-Control-Allow-Origin"  = "'*'"
        "Access-Control-Allow-Methods" = "'OPTIONS,GET,POST,PUT,DELETE'"
        "Access-Control-Allow-Headers" = "'Content-Type,Authorization'"
    }
}
