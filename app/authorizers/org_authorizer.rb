class OrgAuthorizer < ApplicationAuthorizer

  def self.readable_by?(user)
    true
  end

  def self.creatable_by?(user)
    user.admin?
  end

  def updatable_by?(user)
    user.admin_for? resource, :admin
  end

  def deletable_by?(user)
    user.admin_for? resource, :admin
  end

end