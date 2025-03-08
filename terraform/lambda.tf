resource "aws_lambda_function" "inventory_lambda" {
    function_name    = "InventoryFunction"
    role             = aws_iam_role.lambda_role.arn
    runtime          = "python3.12"
    handler          = "lambda_function.lambda_handler"
    filename         = lambda_function.zip
    source_code_hash = filebase64sha256("lambda_function.zip")
    environment {
        variables = {
            TABLE_NAME = "InventoryTable"
        }
    }
}