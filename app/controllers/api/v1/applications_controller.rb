module Api
    module V1
        class ApplicationsController < ApplicationController
            include Utils
            before_action :set_application, only: [:show]
            skip_before_action :verify_authenticity_token

            def index
                @applications = Application.paginate(page: params[:page], per_page: params[:per_page] || 10)
                render json: {
                    applications: ActiveModelSerializers::SerializableResource.new(@applications, each_serializer: ApplicationSerializer),
                    meta: pagination_meta(@applications)
                }, status: :ok         
            end

            def show
                render json: @application, serializer: ApplicationSerializer
            end

            def create
                begin
                  @application = Application.new(application_params)
                  @application.token = generate_random_token(8)
  
                  if @application.save
                    
                      render json: @application, status: :created
                  else
                      render json: @application.errors, status: :unprocessable_entity
                  end
                rescue ActiveRecord::RecordNotUnique => e
                  create
                end
            end

            private

            def set_application
              @application = Application.find_by(token: params[:application_token])
              if @application.nil?
                render json: { error: "Application not found" }, status: :not_found
              end
            end

            def application_params
                params.require(:application).permit(:name)
            end

            def pagination_meta(object)
              {
                current_page: object.current_page,
                next_page: object.next_page,
                prev_page: object.previous_page,
                total_pages: object.total_pages,
                total_count: object.total_entries
              }
            end
        end
    end
end


