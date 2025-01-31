module Api
  module V1
    class ProtectedResourceController < ApplicationController
      include TokenAuthentication

      before_action :authenticate_request

      def create
        render json: {
          message: "Autenticação bem-sucedida! Você está autorizado a acessar os recursos protegidos da API.",
          status: "authorized"
        }
      end
    end
  end
end