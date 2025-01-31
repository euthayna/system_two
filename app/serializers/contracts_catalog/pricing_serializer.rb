class ContractsCatalog::PricingSerializer
  include JSONAPI::Serializer

  set_type :pricing # Defines the JSON:API type
  attributes :price_per_unit, :currency
end 