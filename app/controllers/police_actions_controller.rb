class PoliceActionsController < ApplicationController
  def show
    @police_action = PoliceAction.find params[:id]
  end

  def index
    if params['start_date'].blank? && params['end_date'].blank?
      @police_actions = PoliceAction.all
    elsif params['start_date'].blank?
      @police_actions = PoliceAction.find_in_datetime_range DateTime.strptime('0', '%s'), DateTime.strptime(params['end_date'], '%Y%m%d')
    elsif params['end_date'].blank?
      @police_actions = PoliceAction.find_in_datetime_range DateTime.strptime(params['start_date'], '%Y%m%d'), DateTime.strptime('3000', '%Y')
    end
      
  end
end
