# frozen_string_literal: true

module V1
  class ItemsController < ApplicationController
    def index
      items = project.items
      render json: ItemSerializer.serialize_collection(items)
    end

    def show
      item = project.items.find(params[:id])
      render json: ItemSerializer.new(item)
    end

    private

    def project
      @_project ||= current_user.projects.find(params[:project_id])
    end
  end
end
