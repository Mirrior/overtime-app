FactoryBot.define do
  factory :post do
    date Date.today
    rationale "Maybe in Russia"
    user
  end

  factory :second_post, class: "Post" do
    date Date.yesterday
    rationale "Probably in Russia"
    user
  end
end