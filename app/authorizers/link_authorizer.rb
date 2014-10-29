class LinkAuthorizer < ApplicationAuthorizer

  def creatable_by?(user)
    user.creds_for? resource.org, :admin
  end

  def deletable_by?(user)
    user.creds_for? resource.org, :admin
  end

end