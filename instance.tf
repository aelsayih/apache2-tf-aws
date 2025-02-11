resource "aws_instance" "medoman" {
  ami                    = data.aws_ami.amiID.id
  instance_type          = var.instance_type
  key_name               = "elsayih-key"
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  availability_zone      = "us-east-1a"

  provisioner "file" {
    source      = "web.sh"
    destination = "/tmp/web.sh"
  }

  connection {
    type        = "ssh"
    user        = var.webuser
    private_key = file("elsayihkey")
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = ["chmod +x /tmp/web.sh", "sudo /tmp/web.sh"]
  }
}

output "ec2_public_ip" {
  description = "ec2_public_ip"
  value       = aws_instance.medoman.public_ip

}

output "ec2_private_ip" {
  description = "ec2_private_ip"
  value       = aws_instance.medoman.private_ip
}