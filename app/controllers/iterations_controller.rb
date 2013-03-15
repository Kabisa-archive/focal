class IterationsController < ApplicationController
  before_filter :load_burndown, :validate_burndown_password

  def show
    @iteration = @burndown.iterations.find_by_number(params[:id]).decorate
  end

  private

  def load_burndown
    @burndown  = Burndown.find(params[:burndown_id]).decorate
  end

  def validate_burndown_password
    return if !@burndown.password_protected?

    digest = session.fetch(@burndown.session_identifier, '')
    redirect_to protected_burndown_path(@burndown) if !@burndown.authenticated?(digest)
  end
end
