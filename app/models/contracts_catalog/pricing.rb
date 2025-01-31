class ContractsCatalog::Pricing < ApplicationRecord
  belongs_to :product

  validates :price_per_unit, presence: true
  validates :currency, presence: true
end