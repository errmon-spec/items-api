# frozen_string_literal: true

module V1
  class ProjectsController < V1::BaseController
    def index
      pagy, projects = pagy(current_user.projects)
      pagy_headers_merge(pagy)

      render json: ProjectSerializer.serialize_collection(projects)
    end

    def show
      project = current_user.projects.find(params[:id])
      render json: ProjectSerializer.new(project)
    end

    def create
      project = CreateProjectService.call(user: current_user, name: create_params[:name])
      ProjectPublisher.publish(project_id: project.id, token: project.token)
      render json: ProjectSerializer.new(project)
    end

    def destroy
      project = current_user.projects.find(params[:id])
      project.destroy!
      head :ok
    end

    private

    def create_params
      params.require(:project).permit(:name)
    end
  end
end
