class BurndownsController < ApplicationController

	# GET /burndowns/:id
  def show
    @burndown  = Burndown.find(params[:id]).decorate
    @iteration = @burndown.current_iteration.decorate
  end
end
