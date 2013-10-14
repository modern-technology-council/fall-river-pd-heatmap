class PoliceActionsController < ApplicationController

  def show
    @police_action = PoliceAction.find params[:id]
  end

  def index
    start_date = params['start_date'].present? ? DateTime.strptime(params['start_date'], '%Y%m%d') : DateTime.strptime('0', '%s')
    end_date = params['end_date'].present? ?  DateTime.strptime(params['end_date'], '%Y%m%d') : DateTime.strptime('3000', '%Y')
    @police_actions = PoliceAction.suspicious.find_in_datetime_range start_date, end_date 
  end

  def hot_spots
    @hot_spots = PoliceAction.suspicious.top_addresses
  end
end
