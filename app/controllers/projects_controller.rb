class ProjectsController < ApplicationController

  hobo_model_controller

  auto_actions :all

  def show
    @project = find_instance
    @stories = @project.stories.
      search(params[:search], :title, :status).
      order_by(parse_sort_param(:title, :tasks_count, :status))
    hobo_show
  end

end
