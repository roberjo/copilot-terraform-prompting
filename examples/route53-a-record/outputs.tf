output "record_fqdn" {
  description = "Fully qualified domain name of the record."
  value       = aws_route53_record.a_record.fqdn
}
