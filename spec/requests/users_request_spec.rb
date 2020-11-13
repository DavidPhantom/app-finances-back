require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let!(:user) { create(:user) }

  describe 'GET /signup' do
    context 'with successfully request' do
      it do
        get '/signup', as: :json
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'GET #index' do
    context 'with authorization' do
      it do
        get users_path, headers: auth_headers(user), as: :json
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'GET #show' do
    context 'with authorization' do
      it do
        get user_path(user), headers: auth_headers(user), as: :json
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'POST #create' do
    context 'with valid attributes and without authorization' do
      it do
        post users_path, params: { username: 'Ninidze',
                                   email: 'ninidze@sfedu.ru',
                                   password: 'develop',
                                   password_confirmation: 'develop' }, as: :json
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid attributes and without authorization' do
      it 'with invalid username' do
        post users_path, params: { username: '',
                                   email: 'ninidze@sfedu.ru',
                                   password: 'develop',
                                   password_confirmation: 'develop' }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'with invalid email' do
        post users_path, params: { username: 'Ninidze',
                                   email: '',
                                   password: 'develop',
                                   password_confirmation: 'develop' }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'with existing email' do
        post users_path, params: { username: 'Ninidze',
                                   email: user.email,
                                   password: 'develop',
                                   password_confirmation: 'develop' }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'with invalid password' do
        post users_path, params: { username: 'Ninidze',
                                   email: 'ninidze@sfedu.ru',
                                   password: '',
                                   password_confirmation: '' }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'with valid attributes and with authorization' do
      it do
        post users_path, headers: auth_headers(user), params: { user: { username: 'Ninidze',
                                                                        email: 'ninidze@sfedu.ru',
                                                                        password: 'develop',
                                                                        password_confirmation: 'develop' } }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'GET #edit' do
    context 'with authorization' do
      it do
        get edit_user_path(user), headers: auth_headers(user), as: :json
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      it do
        patch user_path(user), headers: auth_headers(user),
                               params: { username: 'Ninidze David',
                                         email: 'davidninidze@sfedu.ru',
                                         password: 'development',
                                         password_confirmation: 'development' }, as: :json
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid attributes' do
      it 'with invalid username' do
        patch user_path(user), headers: auth_headers(user),
                               params: { username: '',
                                         email: 'ninidze@sfedu.ru',
                                         password: 'develop',
                                         password_confirmation: 'develop' }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'with invalid email' do
        patch user_path(user), headers: auth_headers(user),
                               params: { username: 'Ninidze',
                                         email: '',
                                         password: 'develop',
                                         password_confirmation: 'develop' }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'with invalid password' do
        patch user_path(user), headers: auth_headers(user),
                               params: { username: 'Ninidze',
                                         email: 'ninidze@sfedu.ru',
                                         password: 'd',
                                         password_confirmation: 'd' }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
