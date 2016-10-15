class Game::PlayerNotifierMailer < ApplicationMailer
  default :from => 'antonwestman@gmail.com'

  def send_mission_instructions(player)
    @user = player.user
    @mission = player.mission
    mail( :to => @user.email,
    :subject => "Mission ##{player.mission.id} - Instructions" )
  end
end
