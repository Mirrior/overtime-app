2.times do |user|
  User.create!(first_name: "Guest",
               last_name: "#{user}", 
               email: "test#{user}@test.test", 
               password: "aaaaaa", 
               password_confirmation: "aaaaaa"
              )

end

puts "2 users created"

100.times do |post|
  Post.create!(date: Date.today, rationale: "#{post} rationale content", user_id: User.last.id)
end

puts "100 posts have been created"