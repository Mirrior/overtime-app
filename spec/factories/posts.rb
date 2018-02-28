FactoryBot.define do
  factory :post do
    user
    date Date.today
    rationale "Maybe in Russia"
  end

  factory :second_post, class: Post do
    date Date.yesterday
    rationale "Probably in Russia"
    user
  end
end