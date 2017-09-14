class GroupsController < ApplicationController
  def new
    @group = Group.new
  end

  def create
    Group.create(strong_params)
    redirect_to :root
  end

  def edit
  end

  private

  def strong_params
    params.require(:group).permit(:groupname, user_ids: [])
  end

end
