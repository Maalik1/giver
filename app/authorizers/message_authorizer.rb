class MessageAuthorizer < ApplicationAuthorizer

	def readable_by?(user)
  end

  def creatable_by?(user)
  	true
  end

  def updatable_by?(user)
  end

  def deletable_by?(user)
  end

end