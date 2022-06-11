
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
### API
Current requestbody and responsebody are only for presentation. A common response type might be needed later to communicate with client.
#### Create Patient
| | Value |
| ----------- | ----------- |
| URL| http://localhost:8081/patient/create|
| Method| POST |
| Input | {"firstname": "Foo","surname": "Wang", "email": "wang@example.com"} |
| Output| Message of success or fail|
#### Delete Patient
| | Value |
| ----------- | ----------- |
| URL| http://localhost:8081/patient/delete/{id}|
| Method| Get |
| Input |  |
| Output| Message of success or fail|
#### Query Patient'f Information
| | Value |
| ----------- | ----------- |
| URL| http://localhost:8081/patient/query|
| Method| POST |
| Input | {"firstname": "Foo","surname": "Wang", "email": "wang@example.com"} |
| Output| Patient information in JSON format {"p_id", "firstname","surname","email"}|
#### Update Patient's Email
| | Value |
| ----------- | ----------- |
| URL| http://localhost:8081/patient/update|
| Method| POST |
| Input | {"firstname": "Foo","surname": "Wang", "email": "wang@example.com"} |
| Output| Message of success or fail|

## Feedback-Service
Feedback-service now provides create and query functions for feedback and a demo insert function for guidance.
### API
Current requestbody and responsebody are only for presentation. A common response type might be needed later to communicate with client.
#### Create Feedback
| | Value |
| ----------- | ----------- |
| URL| http://localhost:8084/feedback/create|
| Method| POST |
| Input | {"g_id": 0,"feedback": "good"} |
| Output| "Submit feedback successfully!" |
#### Query Feedback
| | Value |
| ----------- | ----------- |
| URL| http://localhost:8084/feedback/query/{g_id}|
| Method| Get |
| Input |  |
| Output| List< Feedback > feedbacks|
#### Add Guidance
| | Value |
| ----------- | ----------- |
| URL| http://localhost:8084/feedback/guidance |
| Method| POST |
| Input | {"g_id": 0, "guidance": "go to see doctor"} |
| Output| "Create guidance successfully!" or "Guidance exists!"|

## Diagnosis-Service
Diagnosis-service provides create diagnosis and guidance functions and query guidance via patient information.
### API
Current requestbody and responsebody are only for presentation. A common response type might be needed later to communicate with client.
#### Create Diagnosis
| | Value |
| ----------- | ----------- |
| URL| http://localhost:8083/diagnosis/create |
| Method| POST |
| Input | {"dia_id": 123, "patientId": 0, "doctorId":1} |
| Output| "Create diagnosis successfully!" or "Diagnosis exists!" |
#### Create Guidance
| | Value |
| ----------- | ----------- |
| URL| http://localhost:8083/guidance/create |
| Method| POST |
| Input | {"dia_id": 123, "guidance": "go to house doctor", "priority": "urgent"} |
| Output| "Create guidance successfully!" or "Guidance exists!" |
#### Query Guidance
| | Value |
| ----------- | ----------- |
| URL| http://localhost:8083/guidance/query |
| Method| POST |
| Input | {"firstname": "Foo","surname": "Wang"} |
| Output| Guidance in Json format |