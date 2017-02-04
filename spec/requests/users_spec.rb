require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let!(:user) { create(:user, email: 'dexter@mail.com', username: 'SrMir') }

  let!(:another_user) { create(:user, email: 'weston@mail.com') }

  describe 'GET /users' do
    it 'returns array of users' do
      get_with_user user, users_path
      expect(response).to have_http_status(200)
      expect(response_data.map { |u| u[:email] }).to match_array [user.email, another_user.email]
      expect(response_data.count).to eq 2
    end

    describe 'pagination' do
      before do
        create_list(:user, 12)
      end

      context 'without param page' do
        it 'returns list of 10 users' do
          get_with_user user, users_path
          expect(response).to have_http_status(200)
          expect(response_data.count).to eq 10
        end
      end
      context 'with param page' do
        it 'returns paged response' do
          get_with_user user, users_path(page: 2)
          expect(response).to have_http_status(200)
          expect(response_data.count).to eq 4
        end
      end
    end

    describe 'searching' do
      context 'with valid search attribute' do
        it 'returns users filtered by search' do
          get_with_user user, users_path(q: { email_cont: 'ter' })
          expect(response).to have_http_status(200)
          expect(response_data.map { |u| u[:email] }).to match_array [user.email]
          expect(response_data.count).to eq 1
        end
      end
      context 'with invalid search attribute' do
        it 'ignores search attribute and returns all users' do
          get_with_user user, users_path(q: { foobar_cont: 'asdfsd' })
          expect(response).to have_http_status(200)
          expect(response_data.map { |u| u[:email] }).to match_array [user.email,
                                                                      another_user.email]
          expect(response_data.count).to eq 2
        end
      end
    end
  end

  describe 'GET /users/:id' do
    it 'returns user' do
      get_with_user user, user_path(user)
      expect(response).to have_http_status(200)
      expect(response_data[:username]).to eq 'SrMir'
    end
  end

  describe 'PUT /users/:id' do
    context 'user tries to update him-/herself' do
      it 'updates and returns user' do
        put_with_user user, user_path(user, username: 'MrSir')
        expect(response).to have_http_status(200)
        expect(response_data[:username]).to eq 'MrSir'
        expect(user.reload.username).to eq 'MrSir'
      end
    end
    context 'user tries to update someone else' do
      let(:someone_else) { create(:user, username: 'Chuklets') }
      it 'returns 401' do
        put_with_user user, user_path(someone_else, username: 'MrSir')
        expect(response).to have_http_status(401)
        expect(someone_else.reload.username).to eq 'Chuklets'
      end
    end
  end
end
