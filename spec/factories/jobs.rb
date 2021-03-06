FactoryGirl.define do
  factory :job do
    url     { "http://#{Faker::Internet.domain_name}" }
    status  'pending'

    factory :successful_job do
      status        'success'
      processed_at  { Time.now }
    end

    factory :failed_job do
      status        'error'
      processed_at  { Time.now }
    end
  end
end