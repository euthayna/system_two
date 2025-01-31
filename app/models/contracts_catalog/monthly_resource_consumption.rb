module ContractsCatalog
  class MonthlyResourceConsumption < ApplicationRecord
    belongs_to :tenant
    belongs_to :product

    validates :total_used, presence: true, numericality: { greater_than_or_equal_to: 0 }
    validates :use_unity, presence: true
    validates :total_cost, presence: true, numericality: { greater_than_or_equal_to: 0 }
    validates :interval, presence: true
    validate :validate_interval_format

    private

    def validate_interval_format
      return if interval.blank?

      unless interval.match?(/\A\d{4}-\d{2}\z/)
        errors.add(:interval, "must be in the format YYYY-MM")
      end
    end
  end
end