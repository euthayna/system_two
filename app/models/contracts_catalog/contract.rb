class ContractsCatalog::Contract < ApplicationRecord
  belongs_to :tenant
  belongs_to :product

  validates :tenant_id, presence: true
  validates :product_id, presence: true
  validates :status, inclusion: { in: %w[draft active expired] }
end