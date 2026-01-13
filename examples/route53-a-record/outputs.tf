output "record_fqdn" {
  description = "Fully qualified domain name of the record."
  value       = var.use_alias ? aws_route53_record.alias_record[0].fqdn : aws_route53_record.a_record[0].fqdn
}
