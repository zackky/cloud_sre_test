## Solution
| No. | Function                            | Infra                   |
| --- | ----------------------------------- | ----------------------- |
| 1   | Domain name resolver                | Route53                 |
| 2   | SSL/TLS                             | Certificate Manager     |
| 3   | Frontend (static)                   | S3, CloudFront          |
| 4   | Database                            | Aurora (MySQL)          |
| 5   | Cache                               | ElastiCache (Redis)     |
| 6   | Backend                             | EKS                     |

## Usage
Run `make help` to see the available management commands.

Run `make terraform ENVIRONMENT=[prod/stag/dev]` to deploy terraform.
```console
$ make terraform ENVIRONMENT=prod
```

Run `make helm ENVIRONMENT=[prod/stag/dev]` to deploy kubernetes.
```console
$ make helm ENVIRONMENT=prod
```
