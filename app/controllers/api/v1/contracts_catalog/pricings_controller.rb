module Api
  module V1
    module ContractsCatalog
      class PricingsController < ApplicationController
        before_action :set_pricing, only: [:show, :update, :destroy]

        def index
          @pricings = ::ContractsCatalog::Pricing.all
          render json: @pricings
        end

        def show
          render json: @pricing
        end

        def create
          @pricing = ::ContractsCatalog::Pricing.new(pricing_params)
          if @pricing.save
            render json: @pricing, status: :created
          else
            render json: @pricing.errors, status: :unprocessable_entity
          end
        end

        def update
          if @pricing.update(pricing_params)
            render json: @pricing
          else
            render json: @pricing.errors, status: :unprocessable_entity
          end
        end

        def destroy
          @pricing.destroy
          head :no_content
        end

        private

        def set_pricing
          @pricing = ::ContractsCatalog::Pricing.find(params[:id])
        end

        def pricing_params
          params.require(:pricing).permit(:product_id, :price_per_unit, :currency)
        end
      end
    end
  end
end