class PoliceActionsController < ApplicationController
  def show
    @police_action = PoliceAction.find params[:id]
  end

  def index
    @police_actions = PoliceAction.all
  end
end
