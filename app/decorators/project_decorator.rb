class ProjectDecorator < Draper::Decorator
  include Draper::LazyHelpers

delegate_all

  def admin_links
    if user_signed_in?
      if current_user.admin_for?(object.org)
        link_to 'Edit', edit_project_path(object) 
        link_to 'Destroy', @project, method: :delete, data: { confirm: 'Are you sure?' }
      end
    end
  end

end
