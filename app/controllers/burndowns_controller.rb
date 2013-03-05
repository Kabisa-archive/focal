class BurndownsController < ApplicationController

	# GET /burndowns/:id
  def show
    @burndown = Burndown.find(params[:id])
  end

  # GET /burndowns/:id/metrics.json
  #
  # Returns JSON data for use with Google Charts API
  def metrics
  	@burndown = Burndown.find(params[:id])
    render json: @burndown.json_data.to_json
  end
end
