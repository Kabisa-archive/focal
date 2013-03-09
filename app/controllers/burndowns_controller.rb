class BurndownsController < ApplicationController

	# GET /burndowns/:id
  def show
    @burndown = Burndown.find(params[:id]).decorate
  end
end
