class Cred < ActiveRecord::Base

  TYPES = %w(admin moderator)

  belongs_to :org
  belongs_to :user
  
end