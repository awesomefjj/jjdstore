class GroupsController < ApplicationController
 before_action :find_group_and_check_permission, only: [:edit, :update, :destroy] 
 before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  def index
    @groups = Group.all
  end

  def new
    @group = Group.new
  end

  def create
     @group = Group.new(group_params)
     @group.user = current_user
     if @group.save
      current_user.join!(@group)
       redirect_to groups_path
     else
       render :new
     end
  end

  def show
      @group = Group.find(params[:id])
      @posts = @group.posts.recent.paginate(:page => params[:page], :per_page => 5)
  end

  def edit
        @group = Group.find(params[:id])
  end

  def update 
    @group = Group.find(params[:id])
    @group.update(group_params)

    redirect_to groups_path, notice: "Update Success"
  end

  def destroy
      @group = Group.find(params[:id])
      @group.destroy
          flash[:alert] = "Group deleted"
          redirect_to groups_path
      
  end

  def join
    @group = Group.find(params[:id])

    if !current_user.is_member_of?(@group)
      current_user.join!(@group)
      flash[:notice] = "加入本论坛版成功"
    else
      flash[:warning] = "你已经是本讨论版成员了"
    end

    redirect_to group_path(@group)
  end

  def quit
    @group = Group.find(params[:id])
    if current_user.is_member_of?(@group)
      current_user.quit!(@group)
      flash[:alert] = "已退出本论坛版"
    else
      flash[:warning] = "本来就不是哦" 
    end
    redirect_to group_path(@group)
  end
  
  private
  def find_group_and_check_permission
    @group = Group.find(params[:id])
    if current_user != @group.user
      redirect_to root_path, alert: "You have no permission"
    end
  end
  def group_params
    params.require(:group).permit(:title, :description)
  end

end
