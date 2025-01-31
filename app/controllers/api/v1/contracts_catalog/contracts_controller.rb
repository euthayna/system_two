module Api
  module V1
    module ContractsCatalog
      class ContractsController < ApplicationController
        before_action :set_contract, only: [:show, :update, :destroy]

        def index
          @contracts = ::ContractsCatalog::Contract.all
          render json: ::ContractsCatalog::ContractSerializer.new(@contracts).serializable_hash
        end

        def show
          render json: ::ContractsCatalog::ContractSerializer.new(@contract).serializable_hash
        end

        def create
          @contract = ::ContractsCatalog::Contract.new(contract_params)
          if @contract.save
            render json: ::ContractsCatalog::ContractSerializer.new(@contract).serializable_hash, status: :created
          else
            render json: @contract.errors, status: :unprocessable_entity
          end
        end

        def update
          if @contract.update(contract_params)
            render json: @contract
          else
            render json: @contract.errors, status: :unprocessable_entity
          end
        end

        def destroy
          @contract.destroy
          head :no_content
        end

        private

        def set_contract
          @contract = ::ContractsCatalog::Contract.find(params[:id])
        end

        def contract_params
          params.require(:data).require(:attributes).permit(:tenant_id, :product_id, :price_id, :start_date, :end_date, :status)
        end
      end
    end
  end
end