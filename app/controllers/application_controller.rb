class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  rescue_from ActionController::ParameterMissing, with: :render_parameter_missing

    private

  def render_not_found(exception)
    render json: {error: exception.message}, status: :expectation_failed
  end

  def render_parameter_missing(exception)
    render json: {error: exception.message}, status: :expectation_failed
  end
  
end
