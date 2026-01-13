# Architecture (Conceptual)

## Stack diagram

```
+---------------------------+
|        Client/User        |
+-------------+-------------+
              |
              v
+-------------+-------------+
|        API Gateway        |
+-------------+-------------+
              |
              v
+-------------+-------------+
|           Lambda          |
+-------------+-------------+
              |
              v
+-------------+-------------+
|            S3             |
+---------------------------+
```

## Request flow

```
Client -> API Gateway -> Lambda -> S3
              ^             |
              |             v
           Route 53       CloudWatch Logs
```

## Notes
- Keep IAM scoped to least privilege
- Use Terraform Cloud remote state; local state only for educational demos
