class Link < ActiveRecord::Base
  include Authority::Abilities

  TYPES = %w(other facebook twitter instagram google youtube vimeo vine tumblr github foursquare dribbble)

  belongs_to :linkable, polymorphic: true

  validates :location, presence: true

end
