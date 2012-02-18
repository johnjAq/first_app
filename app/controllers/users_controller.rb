class UsersController < ApplicationController
#before_filter :authenticate, :only=>[:index, :edit, :update]
#before_filter :correct_user, :only=>[:edit, :update]
#before_filter :admin_user, :only=>:destroy
#before_filter :not_signed_in, :only=>[:create, :new]


def index
	@title = "All users"
	@users = User.paginate(:page=>params[:page])
end


def show
	@user = User.find(params[:id])
	@title = @user.name
end

def new
	@title = "Sign Up"
	@user = User.new
end

def create
	@user = User.new(params[:user])
	if @user.save
		#handle a successful save
		sign_in @user
		flash[:success] = "Welcome to the Sample App!"
		redirect_to @user
	else
		@title ="Sign up"
		render 'new'
	end
end

def edit
	@title = "Edit User"
end

def update
	if @user.update_attributes(params[:user])
		flash[:success] = "Profile updated."
		redirect_to @user
	else
		@title = "Edit user"
		render 'edit'
	end
end

def destroy
	@user = User.find(params[:id])
	if !current_user?(@user)
		@user.destroy 
		flash[:success] = "User destroyed."
		redirect_to users_path
	else
		flash[:error] = "Can't delete own record."
		redirect_to users_path
	end
end


private

def authenticate
	deny_access unless signed_in?
end

def correct_user
	@user = User.find(params[:id])
	redirect_to(root_path) unless current_user?(@user)
end

def admin_user
	redirect_to(root_path) unless current_user.admin?
end

def not_signed_in
	redirect_to(root_path) unless !signed_in?
end

end
