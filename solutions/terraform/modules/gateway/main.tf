terraform {
  required_version = ">= 0.12, < 0.13"
}

resource "aws_internet_gateway" "igw" {
  vpc_id = var.vpc_id

  tags = merge(
    {
      Name = var.igw_name
    },
    var.tags
  )
}

resource "aws_eip" "natgw_ip" {
  vpc = true

  tags = merge(
    {
      Name = "${var.natgw_name}-ip"
    },
    var.tags
  )

  depends_on = [aws_internet_gateway.igw]
}

resource "aws_subnet" "natgw_subnet" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.natgw_subnet_cidr
  map_public_ip_on_launch = true

  tags = merge(
    {
      Name = "${var.natgw_name}-subnet"
    },
    var.tags
  )
}

resource "aws_nat_gateway" "natgw" {
  allocation_id = aws_eip.natgw_ip.id
  subnet_id     = aws_subnet.natgw_subnet.id

  depends_on = [aws_internet_gateway.igw]

  tags = merge(
    {
      Name = var.natgw_name
    },
    var.tags
  )
}

resource "aws_route_table" "route_table_private" {
  vpc_id = var.vpc_id

  tags = merge(
    {
      Name = "route-table-private"
    },
    var.tags
  )
}

resource "aws_route_table" "route_table_public" {
  vpc_id = var.vpc_id

  tags = merge(
    {
      Name = "route-table-public"
    },
    var.tags
  )
}
