class EventTeamUserBlueprint < Blueprinter::Base
    identifier :id
  
    fields :created_at, :updated_at
  
    association :event, blueprint: EventBlueprint
    association :team, blueprint: TeamBlueprint
    association :user, blueprint: UserBlueprint
  end