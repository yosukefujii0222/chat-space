class GroupsController < ApplicationController
  def new
    @group = Group.new
  end

  def create
    @group = Group.new(strong_params)
    if @group.save
    else
      render :new
    end
  end

  def edit
  end

  private

  def strong_params
    params.require(:group).permit(:groupname, user_ids: [])
  end

end
