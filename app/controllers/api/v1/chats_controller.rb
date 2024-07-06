module Api
  module V1
    class ChatsController < ApplicationController
        skip_before_action :verify_authenticity_token
        before_action :set_application
        before_action :set_chat, only: [:show, :update]

      
        def index
          chats = @application.chats.paginate(page: params[:page], per_page: params[:per_page] || 10)
          render_success_response(
            data: ActiveModelSerializers::SerializableResource.new(chats, each_serializer: ChatSerializer),
            message: 'Chats fetched successfully', 
            status: :ok, meta: chats
          )
        end

        def show
            render_success_response(
              data: ActiveModelSerializers::SerializableResource.new(@chat, serializer: ChatSerializer),
              message: 'Chat fetched successfully', 
              status: :ok
            )            
        end

        def create
          chat = nil
          ChatNumber.transaction do
            chat_number = ChatNumber.where(application_token: params[:application_application_token]).lock(true).first_or_create!
            number = chat_number.number
            chat = Chat.new(chat_params)
            name = chat_params[:name]
            chat.number = number + 1
            ChatCreationJob.perform_async(@application.id, name, number + 1)
            chat_number.update(number: number + 1)
          end

          render_success_response(
            data: ActiveModelSerializers::SerializableResource.new(chat, serializer: ChatSerializer),
            message: 'Chats created successfully', 
            status: :ok
          )
        end

        def update
          if @chat.update(chat_params)
            render_success_response(
              data: ActiveModelSerializers::SerializableResource.new(@chat, serializer: ChatSerializer),
              message: 'Chat updated successfully', 
              status: :ok
            )            
          else
            render_error_response(@chat.errors, status: :unprocessable_entity)
          end
        end
    
        private
    
        def set_application
          @application = Application.find_by!(token: params[:application_application_token])
        end

        def set_chat
          @chat = @application.chats.find_by!(number: params[:number])
        end

        def chat_params
          params.require(:chat).permit(:name)
        end
    
    end  
  end
end


