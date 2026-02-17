resource "aws_vpc" "aws_vpc_device" {
    cidr_block = var.cidr_block

    tags = merge(
        var.aws_tags,
        {
            Name = "provision_${var.provision_id}_vpc_${var.key_suffix}"
        }
    )
}

resource "aws_subnet" "aws_subnet_device" {
    vpc_id     = aws_vpc.aws_vpc_device.id
    cidr_block = var.cidr_block

    map_public_ip_on_launch = true

    tags = merge(
        var.aws_tags,
        {
            Name = "provision_${var.provision_id}_subnet_${var.key_suffix}"
        }
    )

    timeouts {
        delete = "30m"
    }
}

resource "aws_internet_gateway" "aws_internet_gateway_device" {
    vpc_id = aws_vpc.aws_vpc_device.id

    tags = merge(
        var.aws_tags,
        {
            Name = "provision_${var.provision_id}_internet_gateway_${var.key_suffix}"
        }
    )

    timeouts {
        delete = "30m"
    }
}

resource "aws_route" "aws_route_device" {
    route_table_id         = aws_vpc.aws_vpc_device.main_route_table_id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id             = aws_internet_gateway.aws_internet_gateway_device.id

    timeouts {
        delete = "30m"
    }
}

resource "aws_security_group" "aws_security_group_device_all" {
    name        = "allow_all"
    description = "Allow all traffic"
    vpc_id      = aws_vpc.aws_vpc_device.id

    tags = merge(
        var.aws_tags,
        {
            Name = "provision_${var.provision_id}_security_group_${var.key_suffix}"
        }
    )

	ingress {
		from_port   = 0
		to_port     = 0
		protocol    = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}

	egress {
		from_port   = 0
		to_port     = 0
		protocol    = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}
}