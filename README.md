# Doctor-Service
Docotor-service provides:
Doctor: create, delete, query and update
Work: create, delete
Center: create, delete, query

Servies so far runs only with error status:500 internal server error 
You may know more about it?

## API
Will probably change later

### Doctor
#### Create Doctor
| | Value |
| ----------- | ----------- |
| URL| http://localhost:8082/doctors/create|
| Method| POST |
| Input | {"firstname": "Foo","surname": "Wang", "email": "wang@example.com"} |
| Output| Message of success or fail|
#### Delete Doctor
| | Value |
| ----------- | ----------- |
| URL| http://localhost:8082/doctors/delete/{id}|
| Method| Get |
| Input |  |
| Output| Message of success or fail|
#### Query Doctor's Information
| | Value |
| ----------- | ----------- |
| URL| http://localhost:8082/doctors/query|
| Method| POST |
| Input | {"firstname": "Foo","surname": "Wang", "email": "wang@example.com"} |
| Output| Patient information in JSON format {"d_id", "firstname","surname","email"}|
#### Update Doctor's Email
| | Value |
| ----------- | ----------- |
| URL| http://localhost:8082/doctors/update|
| Method| POST |
| Input | {"firstname": "Foo","surname": "Wang", "email": "wang@example.com"} |
| Output| Message of success or fail|

### Workplace Doctor relation
remind that Doctor and Center has to be not empty
create Work does not check if both (doctor, center are correct)
#### Create Work
| | Value |
| ----------- | ----------- |
| URL| http://localhost:8082/work/create|
| Method| POST |
| Input | {"d_id": 0,"c_id": 0} |
| Output| Message of success or fail|
#### Delete Work
| | Value |
| ----------- | ----------- |
| URL| http://localhost:8081/work/delete/|
| Method| Get |
| Input | {"d_id": 0,"c_id": 0} |
| Output| Message of success or fail|


### Location
#### Create Location
| | Value |
| ----------- | ----------- |
| URL| http://localhost:8082/location/create|
| Method| POST |
| Input | {"name": "mitte", "location":"mitte"} |
| Output| Message of success or fail|
#### Delete location
| | Value |
| ----------- | ----------- |
| URL| http://localhost:8082/location/delete/{id}|
| Method| Get |
| Input |  |
| Output| Message of success or fail|
#### Query Location's Information
| | Value |
| ----------- | ----------- |
| URL| http://localhost:8082/location/query|
| Method| POST |
| Input | {"name":"mitte"} |
| Output| Patient information in JSON format {"l_id", "name","location"}|