require 'rails_helper'

RSpec.describe 'Weapons', type: :request do
  let(:user) { build(:user) }

  describe 'GET /weapons' do
    it 'responds' do
      get_with_user user, weapons_path
      expect(response).to have_http_status(200)
    end
  end
end
