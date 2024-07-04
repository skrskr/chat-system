module Api
    module V1
        class ApplicationsController < ApplicationController
            include Utils
            before_action :set_application, only: [:show]
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
                      render_error_response(@application.errors, 422)
                  end
                rescue ActiveRecord::RecordNotUnique => e
                  create
                end
            end

            private

            def set_application
              @application = Application.find_by(token: params[:application_token])
              if @application.nil?
                render_error_response("Application not found", 404, "Application not found")
              end
            end

            def application_params
                params.require(:application).permit(:name)
            end
        end
    end
end


