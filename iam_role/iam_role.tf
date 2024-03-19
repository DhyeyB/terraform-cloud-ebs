resource "aws_iam_role" "execution_role" {
  name                = "${var.app_name}-execution_role-${var.env}"
  managed_policy_arns = var.managed_policy_arn != null ? var.managed_policy_arn : []
  assume_role_policy  = file("${var.assume_role_policy_file_path}")
}

resource "aws_iam_role_policy" "execution_policy" {
  count  = var.execution_policy_file_path != null ? 1 : 0
  name   = "execution_policy"
  role   = aws_iam_role.execution_role.name
  policy = file("${var.execution_policy_file_path}")
}