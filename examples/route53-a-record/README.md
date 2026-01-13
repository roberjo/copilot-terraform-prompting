# Route 53 A Record Example

This example creates a simple A record in an existing hosted zone. It also supports an alias record for API Gateway custom domains.

## Files
- `main.tf`: Route 53 record
- `variables.tf`: hosted_zone_id, record_name, record_value, alias settings
- `outputs.tf`: record FQDN

## How to use (standard A record)
1) Provide an existing hosted zone ID.
2) Provide the record name and IPv4 value.
3) Keep `use_alias = false` (default).

## How to use (API Gateway custom domain alias)
1) Set `use_alias = true`.
2) Set `alias_name` and `alias_zone_id` from the API Gateway custom domain output.
3) Keep `record_value` empty.
