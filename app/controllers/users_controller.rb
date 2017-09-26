class UsersController < ApplicationController
  def index
    @users = User.where('name LIKE(?)', "%#{params[:keyword]}%")
    respond_to do |format|
      format.html
      format.jason
    end
  end

  def edit
  end

  def update
  end
end
