class ContractsCatalog::ContractSerializer
  include JSONAPI::Serializer

  set_type :contract # Defines the JSON:API type
  attributes :start_date, :end_date, :status

  belongs_to :tenant
  belongs_to :product
end 