class Client < ApplicationRecord
  before_validation :generate_credentials

  validates :name, presence: true
  validates :client_id, presence: true, uniqueness: true
  validates :client_secret, presence: true

  def authenticate_client?(provided_secret)
    ActiveSupport::SecurityUtils.secure_compare(self.client_secret, provided_secret)
  end

  private

  def generate_credentials
    self.client_id ||= SecureRandom.hex(10)
    self.client_secret ||= SecureRandom.hex(20)
  end
end

