# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
#
UsersModule::User.create!(name:  "Kartik Verma",
             user_name: "kiwi",
             email_id: "kartx111@gmail.com",
             password: "kartik",
             password_confirmation: "kartik")

# Creating Users
30.times do |i|
  name  = Faker::Name.name
  email_id= "sampleEmail_#{i+1}@twitterkiwi.com"
  password = "123456"
  UsersModule::User.create!(name:  name,
               user_name: "user_#{i+1}",
               email_id: email_id,
               password: password,
               password_confirmation: password)
end

# Creating Userposts
users = UsersModule::User.order(:created_at).take(2)
20.times do
  content = Faker::Lorem.sentence(5)
  users.each {
    |user| user.userposts.create!(content: content)
  }
end

# Creating the follower/following relationships
users = UsersModule::User.all
user  = users.first
following = users[2..10]
followers = users[3..30]
following.each { |following| user.follow(following) }

# Make everyone follow first User <myself created as first record in seed>
followers.each { |follower| follower.follow(user) }
