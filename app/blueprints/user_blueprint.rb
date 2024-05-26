# frozen_string_literal: true

class UserBlueprint < Blueprinter::Base
  identifier :id
  fields :first_name, :last_name, :name, :email
  
  view :normal do
    fields :first_name, :last_name, :name, :email, :role
    association :roles, blueprint: RoleBlueprint
  end
end
