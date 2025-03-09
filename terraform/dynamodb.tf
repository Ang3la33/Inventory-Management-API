resource "aws_dynamodb_table" "inventory_table" {
    name          = "InventoryTable"
    billing_mode  = "PAY_PER_REQUEST"
    hash_key      = "item_id"

    attribute {
        name = "item_id"
        type = "S"
    }

    tags = {
        Name = "InventoryTable"
        Environment = "dev"
    }
}