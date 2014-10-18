class Comment < ActiveRecord::Base
  include Authority::Abilities

  belongs_to :user
  belongs_to :project, counter_cache: true

  validates :user_id, presence: true
  validates :project_id, presence: true
  validates :body, presence: true, length: { maximum: 1000, minimum: 2 }

  before_create :gen_uuid
  
protected

  def gen_uuid
    self.uuid = SecureRandom.uuid
  end

end