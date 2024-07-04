module Api
    module V1
        class ApplicationsController < ApplicationController
            before_action :set_application, only: [:show]

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


            private

            def set_application
              @application = Application.find_by(token: params[:application_token])
              if @application.nil?
                render json: { error: "Application not found" }, status: :not_found
              end
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


