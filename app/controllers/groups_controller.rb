class GroupsController < ApplicationController
  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      flash[:notice] = "Group successfully created!"
      render :edit
    else
      flash[:notice] = "Group was not created!"
      redirect_to :back
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      flash[:notice] = "Group was successfully updated!"
      render :edit
    else
      render
    end
  end

  def add
    @group = Group.find(params[:group])
    @user = User.find(params[:user])
    @group.users << @user unless @group.users.exists? @user.id
    flash[:notice] = "User was successfully added!"
    @group.save
    render :edit
  end

  def destroy
    Group.find(params[:id]).destroy
    flash[:notice] = "Group was successfully deleted!"
    redirect_to groups_path
  end

  def remove
    @group = Group.find(params[:group])
    @user = User.find(params[:user])
    @group.users.delete(@user)
    flash[:notice] = "User was successfully removed!"
    render :edit
  end

  private
    def group_params
      params.require(:group).permit(:name)
    end
  end
