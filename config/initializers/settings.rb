class Settings < Settingslogic
  source "#{Rails.root}/config/giver.yml"
  namespace Rails.env
end

Settings.app[:name]   ||= 'Giver'
Settings.app[:domain] ||= 'giver.io'
Settings.app[:url]    ||= 'https://giver.io'