class Donation < ActiveRecord::Base
	include Authority::Abilities
	
  belongs_to :user
  belongs_to :project, counter_cache: true
  belongs_to :reward

  validates :user_id, presence: true
  validates :project_id, presence: true
  validates :reward_id, presence: true
  validates :amount, price: true, numericality: { greater_than_or_equal_to: 1 }
  
  before_create :gen_uuid
  
protected

  def gen_uuid
    self.uuid = SecureRandom.uuid
  end

end
