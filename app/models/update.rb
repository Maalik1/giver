class Update < ActiveRecord::Base
  include Authority::Abilities

  belongs_to :project, counter_cache: true

  validates :project_id, presence: true
  validates :content, presence: true, length: { minimum: 2 }

end
