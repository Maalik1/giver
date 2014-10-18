RSpec::Matchers.define :be_allowed_for do |user|
  match do |url|
    include UrlAccess
    url_allowed?(user, url)
  end
end

RSpec::Matchers.define :be_denied_for do |user|
  match do |url|
    include UrlAccess
    url_denied?(user, url)
  end
end

RSpec::Matchers.define :be_404_for do |user|
  match do |url|
    include UrlAccess
    url_404?(user, url)
  end
end

module UrlAccess
  def url_allowed?(user, url)
    login_as(user)
    visit url
    (status_code != 404 && current_path != new_user_session_path)
  end

  def url_denied?(user, url)
    login_as(user)
    visit url
    (status_code == 404 || current_path == new_user_session_path)
  end

  def url_404?(user, url)
    login_as(user)
    visit url
    status_code == 404
  end
end