require 'rails_helper'

RSpec.describe 'Places', type: :request do
  let(:user) { build(:user) }

  describe 'GET /places' do
    it 'responds' do
      get_with_user user, places_path
      expect(response).to have_http_status(200)
    end
  end
end
