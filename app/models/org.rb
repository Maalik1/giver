class Org < ActiveRecord::Base
  extend FriendlyId

  include Authority::Abilities
  include Bootsy::Container

  has_many :creds
  has_many :users, through: :creds
  has_many :projects
  has_many :links, as: :linkable

  validates :name, presence: true, length: { maximum: 255, minimum: 3 }
  
  after_validation :geocode, if: :location_changed?
  
  mount_uploader :photo, PhotoUploader
  friendly_id    :name, use: :history
  geocoded_by    :location

end