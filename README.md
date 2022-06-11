# README

This is a chat-app api application using ruby on rails

*   To run this application:
    1. clone this repo
    2. cd to chat-app
    3. run "Docker-compose build"
    4. run "Docker-compose up"

*   Here is a list of APIs in this app:
    1. GET 	    localhost:3000/api/apps             "To get all apps"
    2. GET	    localhost:3000/api/apps/token       "To get an app by token"
    3. POST     localhost:3000/api/apps             "To create a new app with name"
        BODY:
        {
            "name": "app name"
        }
    4. PUT	    localhost:3000/api/apps/token       "To update an app"
    5. DELETE 	localhost:3000/api/apps/token       "To delete an app"

    6. GET	    localhost:3000/api/apps/token/chats             "To get all chats for a specific app"
    7. POST     localhost:3000/api/apps/token/chats             "To create new chat for a specific app"
    8. GET	    localhost:3000/api/apps/token/chats/chat_number "To get a chat for a specific app"
    9. DELETE	localhost:3000/api/apps/token/chats/chat_number "To delete a chat for a specific app"

    10. GET	localhost:3000/api/apps/token/chats/chat_number/messages "To get all messages for a specific chat"
    11. POST 	localhost:3000/api/apps/token/chats/chat_number/messages "To create a message for a specific chat with text"
        BODY: 
        {
            "text": "message text"
        }

    12. GET	localhost:3000/api/apps/token/chats/chat_number/messages/message_number "To get a message for a specific chat"
    13. DELETE	localhost:3000/api/apps/token/chats/chat_number/messages/message_number "To delete a message for a specific chat"
    14. GET	localhost:3000/api/apps/token/chats/chat_number/messages/message_number/search "To search for matching messages in a specific chat"
        BODY:
        {
            "search_messages":  
            {
                        "text": "search key"
            }
        }

