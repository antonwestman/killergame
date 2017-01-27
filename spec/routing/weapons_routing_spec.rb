require "rails_helper"

RSpec.describe WeaponsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/weapons").to route_to("weapons#index")
    end

    it "routes to #show" do
      expect(:get => "/weapons/1").to route_to("weapons#show", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/weapons").to route_to("weapons#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/weapons/1").to route_to("weapons#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/weapons/1").to route_to("weapons#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/weapons/1").to route_to("weapons#destroy", :id => "1")
    end

  end
end
