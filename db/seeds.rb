2.times do |user|
  User.create!(first_name: "Edward",
               last_name: "Snowden#{user}", 
               email: "test#{user}@test.test", 
               password: "aaaaaa", 
               password_confirmation: "aaaaaa"
              )

end

puts "2 users created"

100.times do |post|
  Post.create!(date: Date.today, rationale: "In Russia#{post}", user_id: User.last.id)
end

puts "100 posts have been created"