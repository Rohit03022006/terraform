resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name = "${var.env}-remote-app-table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = var.hash_key

  attribute {
    name = var.hash_key
    type = "S"
  }

  tags = {
    name  = "${var.env}-remote-app-table"
    Environment = var.env
  }
}
