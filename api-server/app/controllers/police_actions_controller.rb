class PoliceActionsController < ApplicationController
  def show
    @police_action = PoliceAction.find params[:id]
  end
end
