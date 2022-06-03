# Feedback-Service
Feedback-service now provides create and query functions for feedback and a demo insert function for guidance.
## API
Current requestbody and responsebody are only for presentation. A common response type might be needed later to communicate with client.
### Create Feedback
| | Value |
| ----------- | ----------- |
| URL| http://localhost:8084/feedback/create|
| Method| POST |
| Input | {"g_id": 0,"feedback": "good"} |
| Output| "Submit feedback successfully!" |
### Query Feedback
| | Value |
| ----------- | ----------- |
| URL| http://localhost:8084/feedback/query/{g_id}|
| Method| Get |
| Input |  |
| Output| List< Feedback > feedbacks|
### Add Guidance
| | Value |
| ----------- | ----------- |
| URL| http://localhost:8084/feedback/guidance |
| Method| POST |
| Input | {"g_id": 0, "guidance": "go to see doctor"} |
| Output| "Create guidance successfully!" or "Guidance exists!"|
