require 'rails_helper'

RSpec.describe 'UserToken', type: :request do
  let!(:user) { create(:user) }

  describe 'POST #create' do
    context 'with valid attributes' do
      it do
        get user_token_index_path, params: { email: user.email, password: user.password }, as: :json

        expect(response).to have_http_status(:created)
      end
    end

    context 'without valid attributes' do
      it 'with invalid email' do
        get user_token_index_path, params: { email: 'user.email', password: user.password }, as: :json

        expect(response).to have_http_status(:not_found)
      end

      it 'with invalid password' do
        get user_token_index_path, params: { email: user.email, password: 'user.password' }, as: :json

        expect(response).to have_http_status(:not_found)
      end

      it 'with invalid email && password' do
        get user_token_index_path, params: { email: 'user.email', password: 'user.password' }, as: :json

        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
