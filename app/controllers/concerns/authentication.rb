module Authentication
    extend ActiveSupport::Concern

    included do
      before_action :authenticate_request
    end

    SECRET_KEY = Rails.application.secret_key_base

    def encode(payload, exp = 24.hours.from_now)
      payload[:exp] = exp.to_i
      JWT.encode(payload, SECRET_KEY)
    end

    def decode(token)
      decoded = JWT.decode(token, SECRET_KEY, true, { algorithm: 'HS256' })[0]
      HashWithIndifferentAccess.new(decoded)
    rescue JWT::DecodeError, JWT::ExpiredSignature
      nil
    end

    private

    def authenticate_request
      header = request.headers['Authorization']
      token = header.split(' ').last if header.present?
      decoded = decode(token)
      if decoded && decoded[:user_id]
        @current_user = User.find_by(id: decoded[:user_id])
        render_error('Not Authorized', :unauthorized) unless @current_user
      else
        render_error('Not Authorized', :unauthorized)
      end
    end

    def render_error(message, status)
      render json: {
        errors: [
          {
            status: status.to_s,
            title: Rack::Utils::HTTP_STATUS_CODES[status],
            detail: message
          }
        ]
      }, status: status
    end
  end