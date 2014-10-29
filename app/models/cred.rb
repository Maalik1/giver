class Cred < ActiveRecord::Base

  TYPES = %w(admin moderator)

  belongs_to :org
  belongs_to :user

  scope :admins, -> { where(status: 'admin') }
  scope :mods, -> { where(status: 'moderator') }
  
end