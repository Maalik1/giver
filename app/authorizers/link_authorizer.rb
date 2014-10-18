class LinkAuthorizer < ApplicationAuthorizer

  def creatable_by?(user)
    user.admin_for? resource.org
  end

  def deletable_by?(user)
    user.admin_for? resource.org
  end

end