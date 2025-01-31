class ContractsCatalog::Product < ApplicationRecord
  validates :name, presence: true
  validates :use_unity, presence: true
end