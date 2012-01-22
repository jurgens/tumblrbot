CONFIG = YAML.load(File.open("#{::Rails.root}/config/oauth.yml").read)

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :tumblr, CONFIG['tumblr']['key'], CONFIG['tumblr']['secret']
end