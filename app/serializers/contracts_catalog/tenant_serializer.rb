class ContractsCatalog::TenantSerializer
  include JSONAPI::Serializer

  set_type :tenant # Defines the JSON:API type
  attributes :first_name, :last_name, :email
end 