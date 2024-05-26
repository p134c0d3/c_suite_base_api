class EventBlueprint < Blueprinter::Base
    identifier :id
    fields :title, :location, :date, :created_at, :updated_at

    
    view :normal do
        association :teams, blueprint: TeamBlueprint
      end
    
    view :extended do
        association :teams, blueprint: TeamBlueprint, view: :extended
    end
end