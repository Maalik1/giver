class CommentAuthorizer < ApplicationAuthorizer

  def creatable_by?(user)
  	if user.donated_to?(resource.project)
  	 true
  	elsif user.admin_for?(resource.project.org)
  		true
  	end
  end

  def deletable_by?(user)
  	user.admin_for? resource.project.org
  end

end