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
| URL| http://localhost:8082/doctor/create|
| Method| POST |
| Input | {"firstname": "Anton","surname": "Mustermann", "email": "Anton@Muster.com"} |
| Output| Message of success or fail|
#### Delete Doctor
| | Value |
| ----------- | ----------- |
| URL| http://localhost:8082/doctor/delete/{id}|
| Method| Get |
| Input |  |
| Output| Message of success or fail|
#### Query Doctor's Information
| | Value |
| ----------- | ----------- |
| URL| http://localhost:8082/doctor/query|
| Method| POST |
| Input | {"firstname": "Max","surname": "Mustermann"} |
| Output| Patient information in JSON format {"d_id", "firstname","surname","email"}|
#### Update Doctor's Email
| | Value |
| ----------- | ----------- |
| URL| http://localhost:8082/doctor/update|
| Method| POST |
| Input | {"firstname": "Max","surname": "Mustermann", "email": "Max2@Muster.com"} |
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
| URL| http://localhost:8082/work/delete|
| Method| Get |
| Input | {"d_id": 0,"c_id": 0} |
| Output| Message of success or fail|


### Location
#### Create center
| | Value |
| ----------- | ----------- |
| URL| http://localhost:8082/center/create|
| Method| POST |
| Input | {"name": "Steglitz", "location":"Schlossstraße"} |
| Output| Message of success or fail|
#### Delete location
| | Value |
| ----------- | ----------- |
| URL| http://localhost:8082/center/delete/{id}|
| Method| Get |
| Input |  |
| Output| Message of success or fail|
#### Query Location's Information
| | Value |
| ----------- | ----------- |
| URL| http://localhost:8082/center/query|
| Method| POST |
| Input | {"name":"Mitte"} |
| Output| Patient information in JSON format {"l_id", "name","location"}|