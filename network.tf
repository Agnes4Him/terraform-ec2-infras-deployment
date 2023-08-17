resource "aws_vpc" "project_vpc" {
    cidr_block = var.vpc_cidr_block
    enable_dns_hostnames = true
    tags = {
        Name: "${var.env}-vpc"
    }
}

resource "aws_subnet" "project_subnet-1" {
    vpc_id = aws_vpc.project_vpc.id
    cidr_block = var.subnet_cidr_block
    availability_zone = var.avail_zone
    tags = {
        Name: "${var.env}-subnet-1"
    }
}

resource "aws_internet_gateway" "project_igw" {
    vpc_id = aws_vpc.project_vpc.id
    tags = {
        Name: "${var.env}-igw"
    }
}

// Create a new route table and subnet association...
resource "aws_route_table" "project_rtb" {
    vpc_id = aws_vpc.project_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.project_igw.id
    }
    tags = {
        Name: "${var.env}-rtb"
    }
}

resource "aws_route_table_association" "project_rtb_assoc" {
    subnet_id = aws_subnet.project_subnet-1.id
    route_table_id = aws_route_table.project_rtb.id
}

// Use default route table instead...

/*resource "aws_default_route_table" "project_default_rtb" {
    default_route_table_id = aws_vpc.project_vpc.default_route_table_id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.project_igw.id
    }
    tags = {
        Name: "${var.env}-default_rtb"
    }
}*/