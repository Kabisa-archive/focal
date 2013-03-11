class BurndownsController < ApplicationController

	# GET /burndowns/:id
  def show
    @burndown  = Burndown.find(params[:id])
    redirect_to burndown_iteration_path(@burndown, @burndown.current_iteration.number)
  end
end
