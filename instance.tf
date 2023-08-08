data "aws_ami" "project_ubuntu_ami" {
    most_recent = true
    filter {
        name = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
    }
    owners = ["099720109477"]
}

resource "aws_key_pair" "project_ssh_key" {
    key_name = "server-key"
    public_key = file(var.public_key_location)
}

// Provision instance with docker installed and Nginx docker container running with default page...

/*resource "aws_instance" "project_server" {
    ami = data.aws_ami.project_ubuntu_ami.id
    instance_type = "t2.micro"
    subnet_id = aws_subnet.project_subnet-1.id
    vpc_security_group_ids = [aws_security_group.project_sg.id]
    availability_zone = var.avail_zone
    associate_public_ip_address = true
    enable_dns_hostnames = true
    key_name = aws_key_pair.project_ssh_key.key_name
    tags = {
        Name: "${var.env}-server"
    }
    user_data = file("entry-script-one.sh")
}*/

// Provision instance with Nginx installed and custom message displayed...

/*resource "aws_instance" "project_server" {
    ami = data.aws_ami.project_ubuntu_ami.id
    instance_type = "t2.micro"
    subnet_id = aws_subnet.project_subnet-1.id
    vpc_security_group_ids = [aws_security_group.project_sg.id]
    availability_zone = var.avail_zone
    associate_public_ip_address = true
    enable_dns_hostnames = true
    key_name = aws_key_pair.project_ssh_key.key_name
    tags = {
        Name: "${var.env}-server"
    }
    user_data = file("entry-script-two.sh")
}*/

// Provision instance with Nginx installed and custom html page displayed...

resource "aws_instance" "project_server" {
    ami = data.aws_ami.project_ubuntu_ami.id
    instance_type = "t2.micro"
    subnet_id = aws_subnet.project_subnet-1.id
    vpc_security_group_ids = [aws_security_group.project_sg.id]
    availability_zone = var.avail_zone
    associate_public_ip_address = true
    enable_dns_hostnames = true
    key_name = aws_key_pair.project_ssh_key.key_name
    tags = {
        Name: "${var.env}-server"
    }
    connection {
        type = "ssh"
        host = self.public_ip
        user = "ubuntu"
        private_key = file(var.private_key_location)
    }
    provisioner "remote-exec" {
        inline = [
            "mkdir /home/ubuntu/html"
        ]
    }
    provisioner "file" {
        source = "index.html"
        destination = "/home/ubuntu/html/index.html"
    }
    user_data = file("entry-script-three.sh")
}

output "instance_public_ip" {
  value = aws_instance.project_server.public_ip
}