class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include Pundit

  before_action :authenticate_user!, unless: :devise_controller?

  rescue_from ::Pundit::NotAuthorizedError, with: :not_authorized

  protected

  def not_authorized(exception)
    render json: { error: exception.message }.to_json, status: 401
    nil
  end
end
