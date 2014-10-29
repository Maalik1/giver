class OrgAuthorizer < ApplicationAuthorizer

  def self.readable_by?(user)
    true
  end

  def self.creatable_by?(user)
    user.site_admin?
  end

  def updatable_by?(user)
    user.creds_for? resource, :admin
  end

  def deletable_by?(user)
    user.site_admin?
  end

end