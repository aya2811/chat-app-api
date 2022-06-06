module Api
    class MessagesController < ApplicationController
        def create
            if check_token()
                message = Message.new(number: params[:number])
                message.chat_id = Chatapp.find_by(:number => params[:chat_id]).id
                if message.save
                    render json: {status:'SUCCESS', message:'Saved message', data: message}, status: :ok
                else
                    render json: {status:'ERROR', message:'message not saved', error: message.errors},
                    status: :unprocessable_entity
                end
            end
       end

    end
end