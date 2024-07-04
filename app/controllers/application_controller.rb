class ApplicationController < ActionController::Base
    include ApiResponseHandler
    include ApiExceptionsHandler
end
