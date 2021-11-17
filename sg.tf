resource "aws_security_group" "SG-HTTP-P8" {
  name        = "allow-http"
  description = "http inbound traffic"
  vpc_id      = aws_vpc.project8VPC.id

  
   ingress {
      description      = "http from VPC"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = [aws_vpc.project8VPC.cidr_block]
    }

 ingress {
    description      = "ssh"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = [aws_vpc.project8VPC.cidr_block]
    }
  

    egress {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }

  tags = {
    Name = "allow_http"
  }
}