# Chat System Challenge

### Setup
```bash
# Open Terminal
# 1- Clone repo
git clone https://github.com/skrskr/chat-system.git
cd chat-system

# 2- Set environment variables
# For save time, i set variables with values on example.env
cp example.env .env

# 3- Run project using docker compose
# compose added as subcommand to docker cli after specific version
docker compose up 
# if not working try docker-compose up

# After it build containers
# web app 
# http://localhost:3000

# elasticsearch app 
# http://localhost:9200

# kibana
# http://localhost:5601

```

### Testing
- Check `docs` directory where the postman collection added.
- Import postman collection.
- There is 1 local variable `url` added to postman and 3 global variables `application_token`, `chat_number`, `message_number`.
- When new application, chat and message created there is scripts on postman to update this variables.