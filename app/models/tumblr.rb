class Tumblr

  def self.follow(user, url)
    response = self.access_token(user).post("http://api.tumblr.com/v2/user/follow", {:url => url})
    raise response.message unless response.code.to_i == 200
    true
  end

  def self.access_token(user)
    @access_token ||= user.prepare_access_token
  end
end
