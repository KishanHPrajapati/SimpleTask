class TasksController < ApplicationController 
  before_action :authenticate_user!
  before_action :set_project
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  skip_before_action :set_project, only: [:task_dashboard]

  # GET projects/1/tasks
  def index
    @tasks = @project.tasks
  end

  def task_dashboard
    if current_user.present?
      if current_user.admin?
        @tasks = Task.includes(:user).where('start_time > ? and start_time <= ?', Date.today.at_beginning_of_day, Date.today.at_end_of_day).group_by{|i| i.user.name}
      else
        @tasks = Task.includes(:user).where('start_time > ? and start_time <= ?', Date.today.at_beginning_of_day, Date.today.at_end_of_day).where(user_id: current_user.id)
      end
    else
      redirect_to "/", notice: "Please sign in.."
    end
  end

  def all_task
    if current_user.present?
      @all_task = Task.find_by_user_id(@current_user.id)
      # render template: 'task/allTask'
    end
 end

  # GET projects/1/tasks/1
  def show
  end

  # GET projects/1/tasks/new
  def new
    @task = @project.tasks.build
  end

  # GET projects/1/tasks/1/edit
  def edit
  end

  # POST projects/1/tasks
  def create
    task_params_1 = task_params
    task_params_1[:user_id] = current_user.id
    @task = @project.tasks.build(task_params_1)

    if @task.save!
      redirect_to(@task.project)
    else
      render action: 'new'
    end
  end

  # PUT projects/1/tasks/1
  def update
    if @task.update_attributes(task_params)
      redirect_to(@task.project)
    else
      render action: 'edit'
    end
  end

  # DELETE projects/1/tasks/1
  def destroy
    @task.destroy

    redirect_to @project
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = current_user.projects.find(params[:project_id])
    end

    def set_task
      @task = @project.tasks.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def task_params
      params.require(:task).permit(:name, :description, :status, :project_id,:start_time, :end_time, :user_id)
    end
end
