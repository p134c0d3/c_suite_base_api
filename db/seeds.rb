# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# db/seeds.rb

# Clear existing data
Role.destroy_all
User.destroy_all
Organization.destroy_all
Team.destroy_all
UserRole.destroy_all
UserTeam.destroy_all

# Create roles
super_admin_role = Role.create!(slug: 'super_admin')
org_admin_role = Role.create!(slug: 'org_admin')
user_role = Role.create!(slug: 'user')

# Create a default organization for super admin
default_org = Organization.create!(name: 'Default Organization')

# Create super admin user
super_admin = User.create!(
  email: 'superadmin@example.com',
  password: 'password',
  first_name: 'Super',
  last_name: 'Admin',
  organization: default_org # Super admin is not tied to a specific organization
)
super_admin.roles << super_admin_role

# Create organizations and org admins
organization_data = [
  { name: 'Org 1', admin_email: 'org1admin@example.com', admin_first_name: 'Org1', admin_last_name: 'Admin' },
  { name: 'Org 2', admin_email: 'org2admin@example.com', admin_first_name: 'Org2', admin_last_name: 'Admin' },
  { name: 'Org 3', admin_email: 'org3admin@example.com', admin_first_name: 'Org3', admin_last_name: 'Admin' }
]

organizations = []

organization_data.each do |org_data|
  organization = Organization.create!(name: org_data[:name])
  organizations << organization

  org_admin = User.create!(
    email: org_data[:admin_email],
    password: 'password',
    first_name: org_data[:admin_first_name],
    last_name: org_data[:admin_last_name],
    organization: organization
  )
  org_admin.roles << org_admin_role
end

# Create regular users and assign them to organizations
10.times do |i|
  organization = organizations.sample
  User.create!(
    email: "user#{i + 1}@example.com",
    password: 'password',
    first_name: "User#{i + 1}",
    last_name: "LastName#{i + 1}",
    organization: organization,
    roles: [user_role]
  )
end

# Create teams for each organization and assign users to these teams
organizations.each do |organization|
  3.times do |i|
    team = Team.create!(
      name: "#{organization.name} Team #{i + 1}",
      organization: organization
    )

    # Get users for this organization
    users = organization.users.where.not(id: organization.users.joins(:roles).where(roles: { slug: 'org_admin' }).pluck(:id))

    # Assign some users to the team
    team_members = users.sample(5) # Adjust the number of team members as needed
    team_members.each do |user|
      UserTeam.create!(team: team, user: user)
    end
  end
end

puts "Seed data created successfully!"
