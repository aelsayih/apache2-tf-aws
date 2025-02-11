data "aws_ami" "amiID" {
  most_recent = true

  filter {
    name   = "image-id"
    values = ["ami-04b4f1a9cf54c11d0"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

output "instance_ami_id" {
  description = "AMI ID of Ubuntu instance"
  value       = data.aws_ami.amiID.id
}