class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include Pundit

  before_action :authenticate_user!, unless: :devise_controller?

  rescue_from ::Pundit::NotAuthorizedError, with: :not_authorized
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  protected

  def not_authorized(exception)
    render json: { error: exception.message }.to_json, status: :unauthorized
    nil
  end

  def record_not_found(exception)
    render json: { error: exception.message }.to_json, status: :not_found
    nil
  end
end
