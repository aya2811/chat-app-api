module Api
    class MessagesController < ApplicationController

        def index
            token = params[:app_id]
            if check_token(token) == true
                chat = App.find_by(:token => token).chats.find_by(:number => params[:chat_id])

                if chat.nil?
                    render json: {status:'Not Found', message:'There is no chats with this no.'},
                    status: :not_found
                else
                   
                    messages = chat.messages.order('created_at DESC')
                 
                  
                    if messages.nil? || messages.empty?
                        render json: {status:'Not Found', message:'There is no messages in this chat'},
                        status: :not_found
                    else
                        render json: {status:'SUCCESS', message:'Loaded messages', 
                        data: messages.as_json({:except => [:id,:app_id,:chat_id]})}, status: :ok
                    end
                end
                
            end
        end

        def show
            token = params[:app_id]
            if check_token(token) == true
                chat = App.find_by(:token => token).chats.find_by(:number => params[:chat_id])

                if chat.nil?
                    render json: {status:'Not Found', message:'There is no chats with this no.'},
                    status: :not_found
                else
                    message = chat.messages.find_by(:number => params[:id])
                    if message.nil? 
                        render json: {status:'Not Found', message:'There is no message with this no.'},
                        status: :not_found
                    else
                        render json: {status:'SUCCESS', message:'Loaded messages', 
                        data: message.as_json({:except => [:id,:app_id,:chat_id]})}, status: :ok
                    end
                end
                
            end
        end

        def create
            token = params[:app_id]
            if check_token(token) == true
                chat = App.find_by(:token => token).chats.find_by(:number => params[:chat_id])

                if chat.nil?
                    render json: {status:'Not Found', message:'There is no chats with this no.'},
                    status: :not_found
                else
                    message = Message.new(text: params[:text])
                    message.chat_id = chat.id
                    message.number = message_count(chat)
                    if message.save
                        render json: {status:'SUCCESS', message:'Saved message', 
                        number: message.number}, status: :ok
                    else
                        render json: {status:'ERROR', message:'Message not saved', error: message.errors},
                        status: :unprocessable_entity
                    end
                end
            end
       end

       def destroy
            token = params[:app_id]
            if check_token(token) == true
                chat = App.find_by(:token => token).chats.find_by(:number => params[:chat_id])

                if chat.nil?
                    render json: {status:'Not Found', message:'There is no chats with this no.'},
                    status: :not_found
                else
                    message = chat.messages.find_by(:number => params[:id])
                    if message.nil? 
                        render json: {status:'Not Found', message:'There is no message with this no.'},
                        status: :not_found
                    else
                        message.destroy
                        render json: {status:'SUCCESS', message:'Deleted message', 
                        data: message.as_json({:except => [:id, :app_id, :chat_id]})}, status: :ok
                    end
                end
                
            end

        end

        def message_count(chat)
            count = $redis.get(chat.app_id.to_s +  chat.id.to_s) rescue nil
            if count.nil?
                count = chat.messages.count
                chat.update(message_count: count + 1)
                $redis.set(chat.app_id.to_s +  chat.id.to_s, count + 1)
                $redis.expire(chat.app_id.to_s +  chat.id.to_s, 1.hour.to_i)
            else
                $redis.set(chat.app_id.to_s +  chat.id.to_s, (count.to_i)+1)
            end
            return (count.to_i)+1
        end

        def search
            token = params[:app_id]
            if check_token(token) == true
                chat = App.find_by(:token => token).chats.find_by(:number => params[:chat_id])

                if chat.nil?
                    render json: {status:'Not Found', message:'There is no chats with this no.'},
                    status: :not_found
                else
                    query = params[:search_messages].presence && params[:search_messages][:text]
          
                    if query
                        messages = Message.search_for_chat(query, chat.id)
                    end
                                    
                    if messages.nil? || messages.empty?
                        render json: {status:'Not Found', message:'There is no matching messages in this chat'},
                        status: :not_found
                    else
                        render json: {status:'SUCCESS', message:'Loaded messages', 
                        data: messages.as_json({:except => [:id,:app_id,:chat_id]})}, status: :ok
                    end
                end
                
            end
        end

    

    end
end