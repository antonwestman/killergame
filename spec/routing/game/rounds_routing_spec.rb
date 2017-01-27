require "rails_helper"

RSpec.describe Game::RoundsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/game/rounds").to route_to("game/rounds#index")
    end

    it "routes to #show" do
      expect(:get => "/game/rounds/1").to route_to("game/rounds#show", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/game/rounds").to route_to("game/rounds#create")
    end

    it "routes to #destroy" do
      expect(:delete => "/game/rounds/1").to route_to("game/rounds#destroy", :id => "1")
    end

  end
end
