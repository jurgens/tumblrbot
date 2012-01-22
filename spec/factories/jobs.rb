FactoryGirl.define do
  factory :job do
    url 'http://someurl.tumblr.com'
    status 'pending'

    factory :successful_job do
      status 'success'
    end

    factory :failed_job do
      status 'error'
    end
  end
end