resource "aws_iam_role" "role" {
  name = "${var.name_prefix}-eks-role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "cluster-policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.role.name
}

resource "aws_iam_role_policy_attachment" "service-policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.role.name
}

resource "aws_eks_cluster" "eks" {
  name     = "${var.name_prefix}-eks"
  role_arn = aws_iam_role.role.arn

  vpc_config {
    security_group_ids = var.security_groups
    subnet_ids         = var.subnet_ids
  }

  tags = merge(
    {
      Name = "${var.name_prefix}-eks"
    },
    var.tags
  )

  depends_on = [
    aws_iam_role_policy_attachment.cluster-policy,
    aws_iam_role_policy_attachment.service-policy,
  ]
}
