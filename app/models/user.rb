class User < ActiveRecord::Base
  extend FriendlyId

  include Authority::UserAbilities

  has_many :creds
  has_many :orgs, through: :creds
  has_many :donations
  has_many :projects, through: :donations
  has_many :messages
  has_many :comments

  validates :name,  presence: true, length: { maximum: 255, minimum: 2 }
  validates :email, uniqueness: true

  before_save :clean_name

  mount_uploader :photo, PhotoUploader
  friendly_id    :name, use: :history
  devise         :invitable, :database_authenticatable, :registerable,
                 :recoverable, :rememberable, :trackable, :validatable
  
  scope :admins, -> { where(admin: true) }
  scope :donors, -> { where.not(stripe_id: nil) }
  scope :without_donation, -> { where(stripe_id: nil) }

  # Check if user has full site wide rights
  def site_admin?
    admin
  end

  # Check if user has any admin rights
  def admin?
  	return true if admin
    self.creds.admins.present?
  end

  # Check if user has any credentials for any org
  def has_creds?
    self.creds.present?
  end
  
  # Check if user has credentials for this Org 
  # And optionally check admin role
  def creds_for?(org, role=nil)
  	return true if admin

    cred = self.creds.find_by_org_id(org.id)
    return false unless cred

    if role
      true if cred.status == role.to_s
    else
      true
    end
  end

  def is_customer?
  	stripe_id.present?
  end

  # Check if user has donated to a project
  def donated_to?(project)
    self.donations.exists?(project_id: project.id)
  end

  # Check if user made a specific donation
  def made_donation?(donation)
    self.donations.exists? donation.id
  end

  def admin_status_for(org)
  	creds = self.creds.find_by_org_id(org.id)
  	creds.status
  end

  def self.create_from_name_and_email(name, email)
  	return false if exists?(email: email)

  	password = Devise.friendly_token.first(8)
    user     = create(name: name, email: email, password: password)
    UserMailer.new_donor_email(email, password).deliver if user

	  user
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