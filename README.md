# README

This is a chat-app api application using ruby on rails

*   To run this application:
    1. clone this repo
    2. cd to chat-app
    3. run "Docker-compose build"
    4. run "Docker-compose up"

*   Here is a list of APIs in this app:
    1. "To get all apps":
    GET 	    localhost:3000/api/apps             
    2. "To get an app by token":
    GET	    localhost:3000/api/apps/token       
    3. "To create a new app with name":
    POST     localhost:3000/api/apps             
        BODY:
        {
            "name": "app name"
        }
    4. "To update an app":
    PUT	    localhost:3000/api/apps/token       
    5. "To delete an app":
    DELETE 	localhost:3000/api/apps/token       

    6. "To get all chats for a specific app":
    GET	    localhost:3000/api/apps/token/chats             
    7. "To create new chat for a specific app":
    POST     localhost:3000/api/apps/token/chats             
    8. "To get a chat for a specific app":
    GET	    localhost:3000/api/apps/token/chats/chat_number 
    9.  "To delete a chat for a specific app":
    DELETE	localhost:3000/api/apps/token/chats/chat_number

    10. "To get all messages for a specific chat":
    GET	localhost:3000/api/apps/token/chats/chat_number/messages 
    11. "To create a message for a specific chat with text"
    POST 	localhost:3000/api/apps/token/chats/chat_number/messages 
        BODY: 
        {
            "text": "message text"
        }

    12. "To get a message for a specific chat":
    GET	localhost:3000/api/apps/token/chats/chat_number/messages/message_number 
    13. "To delete a message for a specific chat":
    DELETE	localhost:3000/api/apps/token/chats/chat_number/messages/message_number 
    14.  "To search for matching messages in a specific chat":
    GET	localhost:3000/api/apps/token/chats/chat_number/messages/message_number/search
        BODY:
        {
            "search_messages":  
            {
                        "text": "search key"
            }
        }

