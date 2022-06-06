require 'TokenManager.rb'
class ApplicationController < ActionController::API
    include TokenManager

    def create_token(app_id)
        return generate_token(app_id)
    end

    def check_token(token)
        dtoken = decrypt_token(token)
        if dtoken
            app = App.find(dtoken[:id])
            if app
                return true
            else
                render json: {status:'ERROR', message:'Not found'}, status: :not_found
            end
        end
        render json: {status:'ERROR', message:'Token Unacceptable'}, status: :not_found
    end
end
