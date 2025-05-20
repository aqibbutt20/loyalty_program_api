class ApplicationController < ActionController::API
  before_action :authenticate_client!

  private

  def authenticate_client!
    api_key = request.headers['X-API-Key']
    unless api_key == Rails.application.credentials.client_api_key
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end
end
