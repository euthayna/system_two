class ContractsCatalog::ProductSerializer
    include JSONAPI::Serializer
  
    set_type :product # Defines the JSON:API type
    attributes :name, :description, :use_unity
  end
  