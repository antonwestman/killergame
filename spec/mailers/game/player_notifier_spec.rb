require 'rails_helper'

RSpec.describe Game::PlayerNotifierMailer, type: :mailer do
  describe "send_mission_instructions" do
    let(:user) { create(:user, username: 'Mr killer dawg sir') }
    let(:player) { create(:player, :with_mission, user: user) }
    let(:mail) { Game::PlayerNotifierMailer.send_mission_instructions(player) }

    it "renders the headers" do
      expect(mail.subject).to eq("Mission ##{player.mission.id} - Instructions")
      expect(mail.to).to eq([player.email])
      expect(mail.from).to eq(["antonwestman@gmail.com"])
    end

    it "renders the body" do
      mail_body = mail.body.encoded
      expect(mail_body).to include("Hello, Mr killer dawg sir", "Here are your instructions")
    end
  end
end
