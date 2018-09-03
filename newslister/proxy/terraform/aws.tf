# --- aws resources for region ap-northeast-1 ---

provider "aws" {
  region = "ap-northeast-1"
  alias  = "ap-northeast-1"
}

resource "aws_security_group" "sg_ap-northeast-1" {
  provider    = "aws.ap-northeast-1"
  name        = "newslister-ap-northeast-1-sg"
  description = "Allow incoming socks5 proxy traffic"

  ingress {
    from_port   = 1080
    to_port     = 1080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "ec2_ap-northeast-1" {
  provider = "aws.ap-northeast-1"

  count                       = "${var.counts["ap-northeast-1"]}"
  ami                         = "ami-0cf78ae724f63bac0"
  instance_type               = "t2.nano"
  associate_public_ip_address = true
  vpc_security_group_ids      = ["${aws_security_group.sg_ap-northeast-1.id}"]
  user_data                   = "${var.user_data}"

  tags {
    Name    = "newslister.ap-northeast-1"
    Project = "newslister"
  }
}

# --- aws resources for region ap-northeast-2 ---

provider "aws" {
  region = "ap-northeast-2"
  alias  = "ap-northeast-2"
}

resource "aws_security_group" "sg_ap-northeast-2" {
  provider    = "aws.ap-northeast-2"
  name        = "newslister-ap-northeast-2-sg"
  description = "Allow incoming socks5 proxy traffic"

  ingress {
    from_port   = 1080
    to_port     = 1080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "ec2_ap-northeast-2" {
  provider = "aws.ap-northeast-2"

  count                       = "${var.counts["ap-northeast-2"]}"
  ami                         = "ami-08cfa02141f9e9bee"
  instance_type               = "t2.nano"
  associate_public_ip_address = true
  vpc_security_group_ids      = ["${aws_security_group.sg_ap-northeast-2.id}"]
  user_data                   = "${var.user_data}"

  tags {
    Name    = "newslister.ap-northeast-2"
    Project = "newslister"
  }
}

# --- aws resources for region ap-south-1 ---

provider "aws" {
  region = "ap-south-1"
  alias  = "ap-south-1"
}

resource "aws_security_group" "sg_ap-south-1" {
  provider    = "aws.ap-south-1"
  name        = "newslister-ap-south-1-sg"
  description = "Allow incoming socks5 proxy traffic"

  ingress {
    from_port   = 1080
    to_port     = 1080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "ec2_ap-south-1" {
  provider = "aws.ap-south-1"

  count                       = "${var.counts["ap-south-1"]}"
  ami                         = "ami-0aba92643213491b9"
  instance_type               = "t2.nano"
  associate_public_ip_address = true
  vpc_security_group_ids      = ["${aws_security_group.sg_ap-south-1.id}"]
  user_data                   = "${var.user_data}"

  tags {
    Name    = "newslister.ap-south-1"
    Project = "newslister"
  }
}

# --- aws resources for region ap-southeast-1 ---

provider "aws" {
  region = "ap-southeast-1"
  alias  = "ap-southeast-1"
}

resource "aws_security_group" "sg_ap-southeast-1" {
  provider    = "aws.ap-southeast-1"
  name        = "newslister-ap-southeast-1-sg"
  description = "Allow incoming socks5 proxy traffic"

  ingress {
    from_port   = 1080
    to_port     = 1080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "ec2_ap-southeast-1" {
  provider = "aws.ap-southeast-1"

  count                       = "${var.counts["ap-southeast-1"]}"
  ami                         = "ami-0cf24653bcf894797"
  instance_type               = "t2.nano"
  associate_public_ip_address = true
  vpc_security_group_ids      = ["${aws_security_group.sg_ap-southeast-1.id}"]
  user_data                   = "${var.user_data}"

  tags {
    Name    = "newslister.ap-southeast-1"
    Project = "newslister"
  }
}

# --- aws resources for region ap-southeast-2 ---

provider "aws" {
  region = "ap-southeast-2"
  alias  = "ap-southeast-2"
}

resource "aws_security_group" "sg_ap-southeast-2" {
  provider    = "aws.ap-southeast-2"
  name        = "newslister-ap-southeast-2-sg"
  description = "Allow incoming socks5 proxy traffic"

  ingress {
    from_port   = 1080
    to_port     = 1080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "ec2_ap-southeast-2" {
  provider = "aws.ap-southeast-2"

  count                       = "${var.counts["ap-southeast-2"]}"
  ami                         = "ami-00c1445796bc0a29f"
  instance_type               = "t2.nano"
  associate_public_ip_address = true
  vpc_security_group_ids      = ["${aws_security_group.sg_ap-southeast-2.id}"]
  user_data                   = "${var.user_data}"

  tags {
    Name    = "newslister.ap-southeast-2"
    Project = "newslister"
  }
}

# --- aws resources for region ca-central-1 ---

provider "aws" {
  region = "ca-central-1"
  alias  = "ca-central-1"
}

resource "aws_security_group" "sg_ca-central-1" {
  provider    = "aws.ca-central-1"
  name        = "newslister-ca-central-1-sg"
  description = "Allow incoming socks5 proxy traffic"

  ingress {
    from_port   = 1080
    to_port     = 1080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "ec2_ca-central-1" {
  provider = "aws.ca-central-1"

  count                       = "${var.counts["ca-central-1"]}"
  ami                         = "ami-b61b96d2"
  instance_type               = "t2.nano"
  associate_public_ip_address = true
  vpc_security_group_ids      = ["${aws_security_group.sg_ca-central-1.id}"]
  user_data                   = "${var.user_data}"

  tags {
    Name    = "newslister.ca-central-1"
    Project = "newslister"
  }
}

# --- aws resources for region eu-central-1 ---

provider "aws" {
  region = "eu-central-1"
  alias  = "eu-central-1"
}

resource "aws_security_group" "sg_eu-central-1" {
  provider    = "aws.eu-central-1"
  name        = "newslister-eu-central-1-sg"
  description = "Allow incoming socks5 proxy traffic"

  ingress {
    from_port   = 1080
    to_port     = 1080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "ec2_eu-central-1" {
  provider = "aws.eu-central-1"

  count                       = "${var.counts["eu-central-1"]}"
  ami                         = "ami-06465d49ba60cf770"
  instance_type               = "t2.nano"
  associate_public_ip_address = true
  vpc_security_group_ids      = ["${aws_security_group.sg_eu-central-1.id}"]
  user_data                   = "${var.user_data}"

  tags {
    Name    = "newslister.eu-central-1"
    Project = "newslister"
  }
}

# --- aws resources for region eu-west-1 ---

provider "aws" {
  region = "eu-west-1"
  alias  = "eu-west-1"
}

resource "aws_security_group" "sg_eu-west-1" {
  provider    = "aws.eu-west-1"
  name        = "newslister-eu-west-1-sg"
  description = "Allow incoming socks5 proxy traffic"

  ingress {
    from_port   = 1080
    to_port     = 1080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "ec2_eu-west-1" {
  provider = "aws.eu-west-1"

  count                       = "${var.counts["eu-west-1"]}"
  ami                         = "ami-0ea87e2bfa81ca08a"
  instance_type               = "t2.nano"
  associate_public_ip_address = true
  vpc_security_group_ids      = ["${aws_security_group.sg_eu-west-1.id}"]
  user_data                   = "${var.user_data}"

  tags {
    Name    = "newslister.eu-west-1"
    Project = "newslister"
  }
}

# --- aws resources for region eu-west-2 ---

provider "aws" {
  region = "eu-west-2"
  alias  = "eu-west-2"
}

resource "aws_security_group" "sg_eu-west-2" {
  provider    = "aws.eu-west-2"
  name        = "newslister-eu-west-2-sg"
  description = "Allow incoming socks5 proxy traffic"

  ingress {
    from_port   = 1080
    to_port     = 1080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "ec2_eu-west-2" {
  provider = "aws.eu-west-2"

  count                       = "${var.counts["eu-west-2"]}"
  ami                         = "ami-e6768381"
  instance_type               = "t2.nano"
  associate_public_ip_address = true
  vpc_security_group_ids      = ["${aws_security_group.sg_eu-west-2.id}"]
  user_data                   = "${var.user_data}"

  tags {
    Name    = "newslister.eu-west-2"
    Project = "newslister"
  }
}

# --- aws resources for region eu-west-3 ---

provider "aws" {
  region = "eu-west-3"
  alias  = "eu-west-3"
}

resource "aws_security_group" "sg_eu-west-3" {
  provider    = "aws.eu-west-3"
  name        = "newslister-eu-west-3-sg"
  description = "Allow incoming socks5 proxy traffic"

  ingress {
    from_port   = 1080
    to_port     = 1080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "ec2_eu-west-3" {
  provider = "aws.eu-west-3"

  count                       = "${var.counts["eu-west-3"]}"
  ami                         = "ami-0050bb60cea70c5b3"
  instance_type               = "t2.nano"
  associate_public_ip_address = true
  vpc_security_group_ids      = ["${aws_security_group.sg_eu-west-3.id}"]
  user_data                   = "${var.user_data}"

  tags {
    Name    = "newslister.eu-west-3"
    Project = "newslister"
  }
}

# --- aws resources for region sa-east-1 ---

provider "aws" {
  region = "sa-east-1"
  alias  = "sa-east-1"
}

resource "aws_security_group" "sg_sa-east-1" {
  provider    = "aws.sa-east-1"
  name        = "newslister-sa-east-1-sg"
  description = "Allow incoming socks5 proxy traffic"

  ingress {
    from_port   = 1080
    to_port     = 1080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "ec2_sa-east-1" {
  provider = "aws.sa-east-1"

  count                       = "${var.counts["sa-east-1"]}"
  ami                         = "ami-09c013530239687aa"
  instance_type               = "t2.nano"
  associate_public_ip_address = true
  vpc_security_group_ids      = ["${aws_security_group.sg_sa-east-1.id}"]
  user_data                   = "${var.user_data}"

  tags {
    Name    = "newslister.sa-east-1"
    Project = "newslister"
  }
}

# --- aws resources for region us-east-1 ---

provider "aws" {
  region = "us-east-1"
  alias  = "us-east-1"
}

resource "aws_security_group" "sg_us-east-1" {
  provider    = "aws.us-east-1"
  name        = "newslister-us-east-1-sg"
  description = "Allow incoming socks5 proxy traffic"

  ingress {
    from_port   = 1080
    to_port     = 1080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "ec2_us-east-1" {
  provider = "aws.us-east-1"

  count                       = "${var.counts["us-east-1"]}"
  ami                         = "ami-0422d936d535c63b1"
  instance_type               = "t2.nano"
  associate_public_ip_address = true
  vpc_security_group_ids      = ["${aws_security_group.sg_us-east-1.id}"]
  user_data                   = "${var.user_data}"

  tags {
    Name    = "newslister.us-east-1"
    Project = "newslister"
  }
}

# --- aws resources for region us-east-2 ---

provider "aws" {
  region = "us-east-2"
  alias  = "us-east-2"
}

resource "aws_security_group" "sg_us-east-2" {
  provider    = "aws.us-east-2"
  name        = "newslister-us-east-2-sg"
  description = "Allow incoming socks5 proxy traffic"

  ingress {
    from_port   = 1080
    to_port     = 1080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "ec2_us-east-2" {
  provider = "aws.us-east-2"

  count                       = "${var.counts["us-east-2"]}"
  ami                         = "ami-0f9c61b5a562a16af"
  instance_type               = "t2.nano"
  associate_public_ip_address = true
  vpc_security_group_ids      = ["${aws_security_group.sg_us-east-2.id}"]
  user_data                   = "${var.user_data}"

  tags {
    Name    = "newslister.us-east-2"
    Project = "newslister"
  }
}

# --- aws resources for region us-west-2 ---

provider "aws" {
  region = "us-west-2"
  alias  = "us-west-2"
}

resource "aws_security_group" "sg_us-west-2" {
  provider    = "aws.us-west-2"
  name        = "newslister-us-west-2-sg"
  description = "Allow incoming socks5 proxy traffic"

  ingress {
    from_port   = 1080
    to_port     = 1080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "ec2_us-west-2" {
  provider = "aws.us-west-2"

  count                       = "${var.counts["us-west-2"]}"
  ami                         = "ami-40d1f038"
  instance_type               = "t2.nano"
  associate_public_ip_address = true
  vpc_security_group_ids      = ["${aws_security_group.sg_us-west-2.id}"]
  user_data                   = "${var.user_data}"

  tags {
    Name    = "newslister.us-west-2"
    Project = "newslister"
  }
}

# --- aws resources for region us-west-1 ---

provider "aws" {
  region = "us-west-1"
  alias  = "us-west-1"
}

resource "aws_security_group" "sg_us-west-1" {
  provider    = "aws.us-west-1"
  name        = "newslister-us-west-1-sg"
  description = "Allow incoming socks5 proxy traffic"

  ingress {
    from_port   = 1080
    to_port     = 1080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "ec2_us-west-1" {
  provider = "aws.us-west-1"

  count                       = "${var.counts["us-west-1"]}"
  ami                         = "ami-0d4027d2cdbca669d"
  instance_type               = "t2.nano"
  associate_public_ip_address = true
  vpc_security_group_ids      = ["${aws_security_group.sg_us-west-1.id}"]
  user_data                   = "${var.user_data}"

  tags {
    Name    = "newslister.us-west-1"
    Project = "newslister"
  }
}

variable "counts" {
  type = "map"

  default = {
    "ap-northeast-1" = "0"
    "ap-northeast-2" = "0"
    "ap-south-1"     = "0"
    "ap-southeast-1" = "0"
    "ap-southeast-2" = "0"
    "ca-central-1"   = "0"
    "eu-central-1"   = "0"
    "eu-west-1"      = "0"
    "eu-west-2"      = "0"
    "eu-west-3"      = "0"
    "sa-east-1"      = "0"
    "us-east-1"      = "0"
    "us-east-2"      = "0"
    "us-west-2"      = "0"
    "us-west-1"      = "0"
  }
}

variable "user_data" {
  default = <<IN
Content-Type: multipart/mixed; boundary="//"
MIME-Version: 1.0

--//
Content-Type: text/cloud-config; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="cloud-config.txt"

#cloud-config
cloud_final_modules:
 - rightscale_userdata
 - scripts-per-once
 - scripts-per-boot
 - scripts-per-instance
 - [scripts-user, always]
 - keys-to-console
 - phone-home
 - final-message
--//
Content-Type: text/x-shellscript; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="userdata.txt"

#!/bin/bash

sudo yum install -y docker
sudo usermod -a -G docker ec2-user
sudo curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-`uname -s`-`uname -m` | sudo tee /usr/local/bin/docker-compose > /dev/null
sudo chmod +x /usr/local/bin/docker-compose
sudo service docker start
sudo chkconfig docker on

sudo cat <<EOF > /etc/docker-compose.yml
version: "3.3"
services:
    proxy:
        image: xkuma/socks5:latest
        ports:
            - "1080:1080"
        environment:
            - "PROXY_USER=foo"
            - "PROXY_PASSWORD=bar"
            - "PROXY_SERVER=0.0.0.0:1080"
EOF
sudo /usr/local/bin/docker-compose -f /etc/docker-compose.yml up -d
--// 
IN
}
