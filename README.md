# Cloud SRE Test

## Conditions for the test

- terraform 0.12.X
- Amazon AWS

### Current configuration

#### Application for web/mobile chat using WebSockets

![](/Images/OnPrem.png)

### Resource

1. DNS Server with zone for app.com
2. Nginx A Server
   1. Reverse Proxy
   2. URL redirect based on URI
   3. Listening on TCP/IP port 80
   4. redirect https://app.com/ to Nginx B Web Server
   5. redirect https://app.com/api/ to Node.js server
3. Nginx B Web Server serving static webpages "index.html" and CSS
4. Node.js service for backend processing
5. Redis keeps clients connectivity state
6. MySql keeps user accounts

## Objective

- migrate to AWS application from OnPrem Data Centre to Amazon AWS
  - Application on AWS should be Highly Available
  - Application on AWS should be Scalable
  - Application on AWS should be Highly Fault Tolerant

### Architect and Design new application diagram for Cloud Native Implementation

- Present Diagram in Draw.io
- Present few options
- From multiple option use one in terraform code

### Write Infrastructure as Code in terraform 0.12

- use remote state
- terraform code should be promotable Dev > Staging > Production
- terraform code should be managed in source control system
