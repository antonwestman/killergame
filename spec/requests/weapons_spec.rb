require 'rails_helper'

RSpec.describe "Weapons", type: :request do
  describe "GET /weapons" do
    it "responds" do
      get weapons_path
      expect(response).to have_http_status(200)
    end
  end
end
