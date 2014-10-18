class DonationAuthorizer < ApplicationAuthorizer

  def readable_by?(user)
    user.admin_for? resource.project.org
  end

  def creatable_by?(user)
    user
  end

end