output "acm_cert" {
  value = aws_acm_certificate_validation.validate_record.certificate_arn
}