# app/controllers/api/v1/base_controller.rb

module Api
  module V1
    class BaseController < ApplicationController
      include ClientAuthentication

      before_action :authenticate_client

      attr_reader :current_client

      private

      def authenticate_client
        header = request.headers['Authorization']
        token = header.split(' ').last if header.present?
        decoded = decode(token)
        if decoded && decoded[:client_id]
          @current_client = Client.find_by(client_id: decoded[:client_id])
          render_error('Not Authorized', :unauthorized) unless @current_client
        else
          render_error('Not Authorized', :unauthorized)
        end
      end
    end
  end
end
