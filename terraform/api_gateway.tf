resource "aws_apigatewayv2_api" "inventory_api" {
    name           = "InventoryAPI"
    protocol_type  = "HTTP" 
}