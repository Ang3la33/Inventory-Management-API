resource "aws_lambda_function" "inventory_lambda" {
    function_name    = "InventoryFunction"
    role             = aws_iam_role.lambda_role.arn
    runtime          = "python3.12"
    handler          = "lambda_function.lambda_handler"
    filename         = "${path.module}/lambda_function.zip"   # Ensure correct path

    environment {
        variables = {
            TABLE_NAME = "InventoryTable"
        }
    }
}
