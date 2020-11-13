class UsersController < ApplicationController
  before_action :authenticate_user, only: [:edit, :update, :index, :show]
  before_action :find_user, only: [:show, :edit, :update]
  before_action :all_users, only: [:index]

  def index
    serialize(@users, :ok)
  end

  def show
    serialize(@user, :ok)
  end

  def new
    @user = User.new(user_params)
    render json: params
  end

  def create
    @user = User.create!(user_params)
    serialize(@user, :created)
  end

  def edit
    serialize(@user, :ok)
  end

  def update
    @user.update!(user_params)
    serialize(@user, :ok)
  end

  private

  def find_user
    @user ||= User.find(params[:id])
  end

  def all_users
    @users ||= User.all
  end

  def serialize(user, status)
    render json: UserSerializer.new(user).serialized_json, status: status
  end

  def user_params
    params.permit(*allowed_parameters)
  end

  def allowed_parameters
    [
      :username, :email, :password, :password_confirmation
    ]
  end
end
