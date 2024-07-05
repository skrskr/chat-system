module Api
    module V1
      class MessagesController < ApplicationController
          skip_before_action :verify_authenticity_token
          before_action :set_chat
          before_action :set_message, only: [:show, :update]
  
        
          def index
            @messages = @chat.messages.paginate(page: params[:page], per_page: params[:per_page] || 10)
            render_success_response(
              data: ActiveModelSerializers::SerializableResource.new(@messages, each_serializer: MessageSerializer),
              message: 'Messages fetched successfully', 
              status: :ok, meta: @messages
            )
          end
  
          def show
              render_success_response(
                data: ActiveModelSerializers::SerializableResource.new(@message, serializer: MessageSerializer),
                message: 'Message fetched successfully', 
                status: :ok
              )            
          end
  
          def create
            @message = @chat.messages.new(message_params)
            @message.number = @chat.messages.count + 1
        
            if @message.save
              render_success_response(
                data: ActiveModelSerializers::SerializableResource.new(@message, serializer: MessageSerializer),
                message: 'Message created successfully', 
                status: :ok
              )          
            else
              render_error_response(@message.errors, status: :unprocessable_entity)
            end
          end
  
          def update
            if @message.update(message_params)
              render_success_response(
                data: ActiveModelSerializers::SerializableResource.new(@message, serializer: MessageSerializer),
                message: 'Message updated successfully', 
                status: :ok
              )            
            else
              render_error_response(@message.errors, status: :unprocessable_entity)
            end
          end
      
          private
      
          def set_chat
            print("set_chat")
            print(params)
            @application = Application.find_by!(token: params[:application_application_token])
            @chat = @application.chats.find_by!(number: params[:chat_number])
          end

          def set_message
            @message = @chat.messages.find_by!(number: params[:number])
          end
  
          def message_params
            params.require(:message).permit(:body)
          end
      
      end  
    end
  end
  
  
  