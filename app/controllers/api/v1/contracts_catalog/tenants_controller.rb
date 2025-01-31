module Api
  module V1
    module ContractsCatalog
      class TenantsController < BaseController
        before_action :set_tenant, only: [:show, :update, :destroy]

        def index
          @tenants = ::ContractsCatalog::Tenant.all
          render json: ::ContractsCatalog::TenantSerializer.new(@tenants).serializable_hash
        end

        def show
          render json: ::ContractsCatalog::TenantSerializer.new(@tenant).serializable_hash
        end

        def create
          @tenant = ::ContractsCatalog::Tenant.new(tenant_params)
          if @tenant.save
            render json: ::ContractsCatalog::TenantSerializer.new(@tenant).serializable_hash, status: :created
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
          params.require(:data).require(:attributes).permit(:first_name, :last_name, :email)
        end
      end
    end
  end
end