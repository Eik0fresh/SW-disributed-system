
# SW-distributed-system

Software focus: New application for the ED (emergency department) of the Charité.

## Gateway
All HTTP-Requests are sent to the gateway. The gateway redirects the request to
the corresponding service. To redirect the requests, all services need to be registered
within a *service discovery module*. As *service discovery module* we use Eureka from
Spring Cloud.

## Eureka
Eureka is a service discovery module from Spring Cloud. Each service (the gateway too)
needs to be registered within Eureka, so the gateway can redirect the requests.

## Patient-Service
Patient-service provides create, delete, update and query functions.
## API
Current requestbody and responsebody are only for presentation. A common response type might be needed later to communicate with client.
### Create Patient
| | Value |
| ----------- | ----------- |
| URL| http://localhost:8081/patient/create|
| Method| POST |
| Input | {"firstname": "Foo","surname": "Wang", "email": "wang@example.com"} |
| Output| Message of success or fail|
### Delete Patient
| | Value |
| ----------- | ----------- |
| URL| http://localhost:8081/patient/delete/{id}|
| Method| Get |
| Input |  |
| Output| Message of success or fail|
### Query Patient'f Information
| | Value |
| ----------- | ----------- |
| URL| http://localhost:8081/patient/query|
| Method| POST |
| Input | {"firstname": "Foo","surname": "Wang", "email": "wang@example.com"} |
| Output| Patient information in JSON format {"p_id", "firstname","surname","email"}|
### Update Patient's Email
| | Value |
| ----------- | ----------- |
| URL| http://localhost:8081/patient/update|
| Method| POST |
| Input | {"firstname": "Foo","surname": "Wang", "email": "wang@example.com"} |
| Output| Message of success or fail|
