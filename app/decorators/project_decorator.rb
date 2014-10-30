class ProjectDecorator < Draper::Decorator
  include Draper::LazyHelpers

  delegate_all

  def feature
  	if object.video.present?
  		content_tag :div, video_iframe, class: 'embed-responsive embed-responsive-16by9'
  	else
  		image_tag object.photo.large.url
  	end
  end

  def video_iframe
  	content_tag :iframe, src: object.video, allowfullscreen: '', class: 'embed-responsive-item'
  end

  def admin_links
    if user_signed_in?
      if current_user.creds_for?(object.org)
        link_to 'Edit', edit_project_path(object) 
        link_to 'Destroy', object, method: :delete, data: { confirm: 'Are you sure?' }
      end
    end
  end

end
