FactoryGirl.define do
  factory :authentication do
    provider  'tumblr'
    uid       '123'
    token     'token'
    secret    'secret'
  end
end