module Api
  module V1
    module ContractsCatalog
      class ProductsController < ApplicationController
        before_action :set_product, only: [:show, :update, :destroy]

        def index
          @products = ::ContractsCatalog::Product.all
          render json: @products
        end

        def show
          render json: @product
        end

        def create
          @product = ::ContractsCatalog::Product.new(product_params)
          if @product.save
            render json: @product, status: :created
          else
            render json: @product.errors, status: :unprocessable_entity
          end
        end

        def update
          if @product.update(product_params)
            render json: @product
          else
            render json: @product.errors, status: :unprocessable_entity
          end
        end

        def destroy
          @product.destroy
          head :no_content
        end

        private

        def set_product
          @product = ::ContractsCatalog::Product.find(params[:id])
        end

        def product_params
          params.require(:product).permit(:name, :description, :use_unity)
        end
      end
    end
  end
end