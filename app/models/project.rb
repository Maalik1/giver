class Project < ActiveRecord::Base
  extend FriendlyId

  include Authority::Abilities

  default_scope { where(active: true) }

  belongs_to :org
  has_many   :rewards
  has_many   :updates
  has_many   :donations
  has_many   :comments
  has_many   :messages
  has_many   :links, as: :linkable

  validates :org_id, presence: true
  validates :title, presence: true, length: { maximum: 255, minimum: 3 }
  validates :story, presence: true, length: { minimum: 50 }
  validates :starts,
             date: { 
             	       after_or_equal_to: Proc.new { Date.today },
                     before: Proc.new { Date.today + 1.year },
                     message: 'date must be after today and within a year' 
                   }
  validates :ends, date: { after: :starts, message: 'date must be after the start date' }
  validates :goal, price: true
  
  after_validation :geocode, if: :location_changed?

  mount_uploader :photo, PhotoUploader
  friendly_id    :title, use: :history
  geocoded_by    :location

end
