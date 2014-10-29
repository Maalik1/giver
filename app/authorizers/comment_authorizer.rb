class CommentAuthorizer < ApplicationAuthorizer

  def creatable_by?(user)
    if user.donated_to?(resource.project)
      true
    elsif user.creds_for?(resource.project.org)
      true
    end
  end

  def deletable_by?(user)
    user.creds_for? resource.project.org
  end

end