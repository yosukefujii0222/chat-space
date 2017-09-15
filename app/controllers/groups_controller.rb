class GroupsController < ApplicationController
  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      redirect_to :root
    else
      render :new
    end
  end

  def edit
    @group = Group.find_by(id: 24)
  end

  def update
    @group = Group.find(params[:id])
    @group.update(group_params)
  end

  private
  def group_params
    params.require(:group).permit(:groupname, user_ids: [])
  end

end
