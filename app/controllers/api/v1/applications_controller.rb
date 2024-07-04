module Api
    module V1
        class ApplicationsController < ApplicationController
            def index
                @applications = Application.paginate(page: params[:page], per_page: params[:per_page] || 10)
                render json: {
                    applications: ActiveModelSerializers::SerializableResource.new(@applications, each_serializer: ApplicationSerializer),
                    meta: pagination_meta(@applications)
                }            
            end


            private

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


