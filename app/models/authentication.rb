class Authentication

  include Mongoid::Document

  field :provider, type: String
  field :uid, type: Integer
  field :token, type: String
  field :secret, type: String

  def prepare_access_token
    consumer = OAuth::Consumer.new(CONFIG['tumblr']['key'], CONFIG['tumblr']['secret'], {:site => "http://www.tumblr.com/"})
    token_hash = {:oauth_token => token, :oauth_token_secret => secret}
    access_token = OAuth::AccessToken.from_hash(consumer, token_hash)
  end

  def self.create_with_omniauth(auth)
    authentication = Authentication.find_or_create_by(provider: auth['provider'], uid: auth['uid']) do |doc|
      doc.token = auth['credentials']['token']
      doc.secret = auth['credentials']['secret']
    end
  end
end
