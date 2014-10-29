class UpdateAuthorizer < ApplicationAuthorizer

  def creatable_by?(user)
    user.creds_for? resource.project.org
  end

  def updatable_by?(user)
    user.creds_for? resource.project.org
  end

  def deletable_by?(user)
    user.creds_for? resource.project.org
  end

end