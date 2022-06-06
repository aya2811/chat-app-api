module Api
    class ChatsController < ApplicationController
        def index
            token = params[:app_id]
            if check_token(token) == true
                chats = App.find_by(:token => token).chats.order('created_at DESC')
                if chats.nil? || chats.empty?
                    render json: {status:'Not Found', message:'There is no chats for this app'},
                    status: :not_found
                else
                    render json: {status:'SUCCESS', message:'Loaded chats', 
                    data: chats.as_json({:except => [:id,:app_id]})}, status: :ok
                end
                
            end
        end 

       def show
            token = params[:app_id]
            if check_token(token) == true
                chat = App.find_by(:token => token).chats.find_by(:number => params[:id])
                if chat.nil?
                    render json: {status:'Not Found', message:'There is no chat with this number'},
                    status: :not_found
                else
                    render json: {status:'SUCCESS', message:'Loaded chat', 
                    data: chat.as_json({:except => [:id, :app_id]})}, status: :ok
                end
            end
        end

        def create
            token = params[:app_id]
            if check_token(token) == true
                chat = Chat.new()
                app = App.find_by(:token => token)
                chat.app_id = app.id
                chat.number = chat_count(app)
                if chat.save
                    render json: {status:'SUCCESS', message:'Saved chat', 
                    number: chat.number}, status: :ok
                else
                    render json: {status:'ERROR', message:'Chat not saved', error: chat.errors},
                    status: :unprocessable_entity
                end
            end
       end

       def destroy
            token = params[:app_id]
            if check_token(token) == true
                chat = App.find_by(:token => token).chats.find_by(:number => params[:id])
                if chat.nil?
                    render json: {status:'Not Found', message:'There is no chat with this number'},
                    status: :not_found
                else
                    chat.destroy
                    render json: {status:'SUCCESS', message:'Deleted chat', 
                    data: chat.as_json({:except => [:id, :app_id]})}, status: :ok
                end
                
            end
        
        end


        def chat_count(app)
            count = $redis.get(app.id.to_s) rescue nil
            if count.nil?
                count = app.chats.count
                app.update(chat_count: count + 1)
                $redis.set(app.id.to_s, count + 1)
                $redis.expire(app.id.to_s, 1.hour.to_i)
            else
                $redis.set(app.id.to_s, (count.to_i)+1)
            end
            return (count.to_i)+1
        end


        
    end
end