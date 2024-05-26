class TeamBlueprint < Blueprinter::Base
    identifier :id 
    fields :name, :created_at, :updated_at

    view :normal do
        association :users, blueprint: UserBlueprint
      end
    
    view :extended do
    association :users, blueprint: UserBlueprint, view: :extended
    end
end