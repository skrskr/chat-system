module Api
  module V1
    class ChatsController < ApplicationController
        skip_before_action :verify_authenticity_token
        before_action :set_application

      
        def index
          @chats = @application.chats.paginate(page: params[:page], per_page: params[:per_page] || 10)
          render_success_response(
            data: ActiveModelSerializers::SerializableResource.new(@chats, each_serializer: ChatSerializer),
            message: 'Chats fetched successfully', 
            status: :ok, meta: @chats
          )
        end

        def create
          @chat = @application.chats.new(chat_params)
          @chat.number = @application.chats.count + 1
      
          if @chat.save
            render_success_response(
              data: ActiveModelSerializers::SerializableResource.new(@chat, serializer: ChatSerializer),
              message: 'Chats created successfully', 
              status: :ok, meta: @chats
            )          
          else
            render_error_response(@chat.errors, status: :unprocessable_entity)
          end
        end
    
        private
    
        def set_application
          @application = Application.find_by!(token: params[:application_application_token])
        end

        def chat_params
          params.require(:chat).permit(:name)
        end
    
    end  
  end
end


