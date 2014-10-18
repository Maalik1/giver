class Reward < ActiveRecord::Base
	include Authority::Abilities

  belongs_to :project

  validates :project_id, presence: true
  validates :amount, price: true, numericality: { greater_than_or_equal_to: 1 }
  validates :description, presence: true, length: { maximum: 1000, minimum: 2 }
  
  before_create :gen_uuid

  def donation_valid?(donation_amount)
  	donation_amount.to_f >= self.amount
  end
  
protected

  def gen_uuid
    self.uuid = SecureRandom.uuid
  end
  
end
