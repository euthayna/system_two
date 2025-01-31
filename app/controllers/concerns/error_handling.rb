# app/controllers/concerns/error_handling.rb

module ErrorHandling
    extend ActiveSupport::Concern

    included do
      rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
      rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
      rescue_from ActionController::ParameterMissing, with: :parameter_missing
      rescue_from ActionDispatch::Http::Parameters::ParseError, with: :bad_request
    end

    private

    # Trata Record Not Found (404)
    def record_not_found(exception)
      render_error(exception.message, :not_found)
    end

    # Trata Erros de Validação (422)
    def record_invalid(exception)
      render_error(exception.record.errors.full_messages, :unprocessable_entity)
    end

    # Trata Parâmetros Faltantes (400)
    def parameter_missing(exception)
      render_error("Missing parameter: #{exception.param}", :bad_request)
    end

    # Trata Erros de Parseamento JSON (400)
    def bad_request(exception)
      render_error("Invalid JSON: #{exception.message}", :bad_request)
    end

    # Formata a Resposta de Erro
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