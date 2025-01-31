module Api
    module V1
      class ClientAuthenticationController < BaseController
        include ClientAuthentication

        skip_before_action :authenticate_client, only: [:authenticate]

        def authenticate
          client = Client.find_by(client_id: params[:client_id])

          if client&.authenticate_client?(params[:client_secret])
            token = ClientAuthentication.encode(client_id: client.client_id)
            render json: { token: token }, status: :ok
          else
            render json: { errors: ['Invalid client credentials'] }, status: :unauthorized
          end
        end

        private

        def client_params
          params.require(:data).require(:attributes).permit(:client_id, :client_secret)
        end
      end
    end
  end