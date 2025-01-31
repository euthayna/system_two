module TokenAuthentication
  extend ActiveSupport::Concern

  SECRET_KEY = Rails.application.credentials.secret_key_base.to_s

  def encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  def decode(token)
    body = JWT.decode(token, SECRET_KEY)[0]
    HashWithIndifferentAccess.new(body)
  rescue JWT::DecodeError, JWT::ExpiredSignature
    nil
  end

  def authenticate_request
    header = request.headers['Authorization']
    token = header.split(' ').last if header.present?
    decoded = decode(token)
    if decoded && decoded[:client_id]
      @current_client = Client.find_by(client_id: decoded[:client_id])
      render json: { errors: ['Not Authorized'] }, status: :unauthorized unless @current_client
    else
      render json: { errors: ['Not Authorized'] }, status: :unauthorized
    end
  end
end 