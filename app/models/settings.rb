class Settings < Settingslogic
  source "#{Rails.root}/config/focal.yml"
  namespace Rails.env
end