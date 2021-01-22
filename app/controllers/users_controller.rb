class UsersController < ApplicationController
  before_action :authorized, except: [:create, :login]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    render json: {user: @user, token: @token}
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
      if @user.save
        @token = encode_token({user_id: @user.id})
        render json: {user: @user, token: @token}
      else
        render json: @user.errors, status: :unprocessable_entity
      end
  end

  def login
    @user = User.find_by(email: user_params[:email])
    if @user && @user.authenticate(user_params[:password])
      @token = encode_token({user_id: @user.id})
      render json: {user: @user, token: @token}
    else
      render json: {error: "Invalid username or password"}
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
      if @user.update(user_params)
        render json: {user: @user, token: @token}
      else
        frender json: @user.errors, status: :unprocessable_entity 
      end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
       head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :email, :password)
    end
end
