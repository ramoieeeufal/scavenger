class UsersController < ApplicationController

private
  def user_params
    params.require(:user).permit(:userame, :name, :email, :password, :password_confirmation)
  end

public
  # GET api/users/new
  # This method is not backend responsability.
  def new_user
    if user_signed_in?
      redirect_to show_user_path(current_user)
    end
  end

  # POST /users/create
  def create_user
    @user = User.new(user_params)

    if @user.save
      render json: {}, status: 200
    else
      render json: {}, status: 400
    end
  end

  # GET /users/:id/edit
  def edit_user
    # TODO: Check if the user is logged into its own account, or if the user
    # has admin privileges.
    if user_signed_in?
      @user = current_user
    else
      redirect_to root_path
    end
  end

  # POST /users/:id/update
  def update_user
    # TODO: Check if the user is logged into its own account.
    @user = current_user

    # TODO: Verify user fields
    if @user.update(params)
      redirect_to show_user_path(@user)
    else
      # TODO: If do not save user, redirect to an error page.
      redirect_to root_path
    end
  end

  # GET /users/:id
  def show_user
    # TODO: Check if the user is logged into its own account or if it has admin
    # privileges.
    @user = current_user
    render json: @user
  end

  # GET /users
  # TODO: this controller must have admin privileges.
  def show_all_users
    @users = User.all
    render json: @users
  end

  # DELETE /users/:id
  # TODO: this controller must have admin privileges.
  def delete_user
    @user = User.find(params[:id])

    if @user.destroy
      redirect_to show_all_users
    end
  end

end
