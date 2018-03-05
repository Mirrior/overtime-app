2.times do |user|
  User.create!(first_name: "Edward",
               last_name: "Snowden#{user}", 
               email: "test#{user}@test.test", 
               password: "aaaaaa", 
               password_confirmation: "aaaaaa",
               phone: "3852437428"
              )

end

puts "2 users created"

AdminUser.create!(first_name: "NotEdward",
               last_name: "NotSnowden", 
               email: "admin@test.test", 
               password: "ssssss", 
               password_confirmation: "ssssss",
               phone: "3852437428"
              )

puts "admin user created"

100.times do |post|
  Post.create!(date: Date.today, rationale: "In Russia#{post}", user_id: User.first.id, overtime_request: 2.5)
end

puts "100 posts have been created"


100.times do |audit_log|
  AuditLog.create!(user_id: User.first.id, status: 0, start_date: Date.today)
end

puts "100 audit logs have been created"