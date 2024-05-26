class TeamEventBlueprint < Blueprinter::Base
    identifier :id 

    association :events, blueprint: EventBlueprint
    association :users, blueprint: UserBlueprint
    association :event_team_users, blueprint: EventTeamUser
    association :team, blueprint: TeamBlueprint
end