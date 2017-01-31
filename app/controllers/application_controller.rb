class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include Pundit
  
  before_action :authenticate_user!, unless: :devise_controller?
end
