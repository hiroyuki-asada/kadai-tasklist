class TasksController < ApplicationController
before_action :require_user_logged_in
before_action :correct_user, only: [:update,:destroy,:show,:edit]

  def index
    @tasks = current_user.tasks.order('created_at DESC')#.page(params[:page])
  end

  def show 
    set_task
  end

  def new
    if logged_in?
      @user = current_user
      @task = current_user.tasks.build  # form_for 用
      @tasks = current_user.tasks.order('created_at DESC')#.page(params[:page])
    end
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = '正常に投稿されました'
      redirect_to @task
    else
      #current_user.tasks.order('created_at DESC')#.page(params[:page])
      flash.now[:danger] = '正常に投稿されませんでした'
      #redirect_to new_task_path
      render :new
    end
  end

  def edit
    set_task
  end

  def update
    
    # @task = current_user.tasks.build(task_params)
    set_task
    
    if @task.update(task_params)
      flash[:success] = '正常に投稿されました'
      redirect_to @task
    else
      flash.now[:danger] = '正常に投稿されませんでした'
      render :edit
    end
  end

  def destroy
    @task.destroy
    flash[:success] = 'メッセージを削除しました。'
    redirect_to tasks_path
  end
  
  

private
  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:content,:title)
  end

  def ensure_correct_user
    @task = Task.find_by(id:params[:id])
    if @task.user_id != @current_user.id
      flash[:notice] = "権限がありません"
      redirect_to("/task")
    end
  end
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to tasks_path
    end
  end
end