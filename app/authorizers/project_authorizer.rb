class ProjectAuthorizer < ApplicationAuthorizer

	def self.default(able, user)
		true
  end

  def self.creatable_by?(user)
  	user.admin?
  end

  def updatable_by?(user)
  	user.admin_for? resource.org, :admin
  end

  def deletable_by?(user)
  	user.admin_for? resource.org, :admin
  end

end