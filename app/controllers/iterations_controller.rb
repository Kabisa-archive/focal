class IterationsController < ApplicationController
  def show
    @burndown  = Burndown.find(params[:burndown_id]).decorate
    @iteration = @burndown.iterations.find_by_number(params[:id]).decorate
  end

  alias_method :print, :show
end
