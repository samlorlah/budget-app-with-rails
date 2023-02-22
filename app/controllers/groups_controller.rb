class GroupsController < ApplicationController
  def index
    @groups = Group.all
  end

  def new
    @group = Group.new
  end

  def create
    @group = current_user.groups.new(group_params)

    if @group.save
      redirect_to groups_url, notice: 'Category was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to groups_url, notice: 'Category was successfully updated.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @group = Group.find(params[:id])

    if @group.destroy
      flash[:success] = 'Category was successfully removed.'
    else
      flash[:error] = 'Error: Category could not be removed'
    end
    redirect_to groups_url
  end

  private
  def group_params
    params.require(:group).permit(:author_id, :name, :icon)
  end

end
