@employee = Employee.create!(first_name: "Some",
             last_name: "Guy", 
             email: "test@test.test", 
             password: "aaaaaa", 
             password_confirmation: "aaaaaa",
             phone: "8018640356"
            )


puts "regular user created"

AdminUser.create!(first_name: "John",
               last_name: "Smith", 
               email: "admin@test.test", 
               password: "ssssss", 
               password_confirmation: "ssssss",
               phone: "3852437428"
              )

puts "admin user created"

AuditLog.create!(user_id: @employee.id, status: 0, start_date: (Date.today - 6.days))
AuditLog.create!(user_id: @employee.id, status: 0, start_date: (Date.today - 13.days))
AuditLog.create!(user_id: @employee.id, status: 0, start_date: (Date.today - 20.days))

puts "3 audit logs have been created"

50.times do |post|
  Post.create!(date: Date.today, rationale: "#{post} Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt.", user_id: Employee.first.id, overtime_request: 2.5)
end

puts "50 posts have been created"
