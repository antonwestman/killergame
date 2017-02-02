require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:user) { build(:user) }
  describe 'GET /users' do
    it 'responds' do
      get_with_user user, users_path
      expect(response).to have_http_status(200)
    end
  end
end
