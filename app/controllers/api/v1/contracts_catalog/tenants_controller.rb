module Api
  module V1
    module ContractsCatalog
      class TenantsController < ApplicationController
        before_action :set_tenant, only: [:show, :update, :destroy]

        def index
          @tenants = ::ContractsCatalog::Tenant.all
          render json: @tenants
        end

        def show
          render json: @tenant
        end

        def create
          @tenant = ::ContractsCatalog::Tenant.new(tenant_params)

          if @tenant.save
            render json: @tenant, status: :created
          else
            render json: @tenant.errors, status: :unprocessable_entity
          end
        end

        def update
          if @tenant.update(tenant_params)
            render json: @tenant
          else
            render json: @tenant.errors, status: :unprocessable_entity
          end
        end

        def destroy
          @tenant.destroy
          head :no_content
        end

        private

        def set_tenant
          @tenant = ::ContractsCatalog::Tenant.find(params[:id])
        end

        def tenant_params
          params.require(:tenant).permit(:first_name, :last_name, :email)
        end
      end
    end
  end
end