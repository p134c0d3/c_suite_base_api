# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
team1 = Team.last 
team2 = Team.first

# Create users for the Worship Team
worship_users = []
8.times do |i|
  worship_users << User.create(email: "worship_user#{i}@example.com", password: 'password', first_name: "WorshipUser#{i}", last_name: "LastName#{i}")
end

# Assign users to the Worship Team
worship_users.each do |user|
  team1.users << user
end

# Create users for the Media Team
media_users = []
12.times do |i|
  media_users << User.create(email: "media_user#{i}@example.com", password: 'password', first_name: "MediaUser#{i}", last_name: "LastName#{i}")
end

# Assign users to the Media Team
media_users.each do |user|
  team2.users << user
end
