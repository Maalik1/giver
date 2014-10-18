class User < ActiveRecord::Base
  extend FriendlyId

  include Authority::UserAbilities

  has_many :creds
  has_many :orgs, through: :creds
  has_many :donations
  has_many :messages
  has_many :comments

  validates :name, presence: true, length: { maximum: 255, minimum: 2 }

  before_create :clean_name

  mount_uploader :photo, PhotoUploader
  friendly_id    :name, use: :history
  devise         :invitable, :database_authenticatable, :registerable,
                 :recoverable, :rememberable, :trackable, :validatable
  
  # Check if user is some sort of admin
  def admin?
    self.creds.present?
  end

  # Check if user is admin for this Org 
  # And optionally check admin role
  def admin_for?(org, role=nil)
    cred = self.creds.find_by_org_id(org.id)
    if role
      true if cred and cred.status == role.to_s
    else
      true if cred
    end
  end

  # Check if user has donated to a project
  def donated_to?(project)
    self.donations.exists?(project_id: project.id)
  end

  # Check if user made a specific donation
  def made_donation?(donation)
    self.donations.exists? donation.id
  end

  def self.create_from_email(email)
    create(email: email, password: Devise.friendly_token.first(8))
  end

protected

  def clean_name
    name       = self.name.gsub(/\s+/m, ' ').strip
    name_array = name.split(' ')

    self.name       = name
    self.first_name = name_array.first
    self.last_name  = name_array.last
  end

end