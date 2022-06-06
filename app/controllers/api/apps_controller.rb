module Api
    class AppsController < ApplicationController
       def index
            apps = App.order('created_at DESC')
            render json: {status:'SUCCESS', message:'Loaded apps', 
            data: apps.as_json({:except => [:id]})}, status: :ok
       end 

       def show
            app = App.find_by(:token => params[:id])
            render json: {status:'SUCCESS', message:'Loaded app', 
            data: app.as_json({:except => [:id]})}, status: :ok
       end 

       def create
            app = App.new(name: params[:name])
            if app.save
                token = self.create_token(app.id.to_s)
                app.update_attribute(:token, token)
                render json: {status:'SUCCESS', message:'Saved app', token: app.token}, status: :ok
            else
                render json: {status:'ERROR', message:'App not saved', error: app.errors},
                status: :unprocessable_entity
            end
       end

       def destroy
            app = App.find_by(:token => params[:id])
            app.destroy
            
            render json: {status:'SUCCESS', message:'Deleted app', 
            data: app.as_json({:except => [:id]})}, status: :ok
          
        end

        def update
            app = App.find_by(:token => params[:id])

            if app.update(name: params[:name])
                render json: {status:'SUCCESS', message:'Updated app', 
                data: app.as_json({:except => [:id]})}, status: :ok
            else
                render json: {status:'ERROR', message:'App not updated', error: app.errors},
                status: :unprocessable_entity
            end
          
        end

       private 

       def app_params
            params.permit(:id)
       end
    end
end
