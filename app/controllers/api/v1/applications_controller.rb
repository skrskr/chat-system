module Api
    module V1
        class ApplicationsController < ApplicationController
            include Utils
            before_action :set_application, only: [:show , :update]
            skip_before_action :verify_authenticity_token

            def index
                @applications = Application.paginate(page: params[:page], per_page: params[:per_page] || 10)
                
                render_success_response(
                  data: ActiveModelSerializers::SerializableResource.new(@applications, each_serializer: ApplicationSerializer),
                  message: 'Applications fetched successfully', 
                  status: :ok, meta: @applications
                )
            end

            def show
                render_success_response(
                  data: ActiveModelSerializers::SerializableResource.new(@application, serializer: ApplicationSerializer),
                  message: 'Application fetched successfully', 
                  status: :ok
                )
            end

            def create
                begin
                  @application = Application.new(application_params)
                  @application.token = generate_random_token(8)
  
                  if @application.save
                    render_success_response(
                      data: ActiveModelSerializers::SerializableResource.new(@application, serializer: ApplicationSerializer),
                      message: 'Application created successfully', 
                      status: :created
                    )
                  else
                      render_error_response(@application.errors, status: :unprocessable_entity)
                  end
                rescue ActiveRecord::RecordNotUnique => e
                  create
                end
            end

            def update
                if @application.update(application_params)
                    render_success_response(
                      data: ActiveModelSerializers::SerializableResource.new(@application, serializer: ApplicationSerializer),
                      message: 'Application updated successfully', 
                      status: :ok
                    )
                else
                    render_error_response(@application.errors, status: :unprocessable_entity)
                end
            end

            private

            def set_application
              @application = Application.find_by(token: params[:application_token])
              if @application.nil?
                render_error_response("Application not found", status: :not_found, message: "Application not found")
              end
            end

            def application_params
                params.require(:application).permit(:name)
            end
        end
    end
end


