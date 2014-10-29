class RewardAuthorizer < ApplicationAuthorizer

  def creatable_by?(user)
    user.creds_for? resource.project.org, :admin
  end

  def updatable_by?(user)
    user.creds_for? resource.project.org, :admin
  end

  def deletable_by?(user)
    user.creds_for? resource.project.org, :admin
  end

end