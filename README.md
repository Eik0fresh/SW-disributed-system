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