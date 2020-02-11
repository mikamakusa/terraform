output "aws_ami_id" {
  value = aws_ami.ami.*.id
}