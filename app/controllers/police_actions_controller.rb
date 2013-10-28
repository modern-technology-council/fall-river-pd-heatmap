class PoliceActionsController < ApplicationController

  def show
    @police_action = PoliceAction.find params[:id]
  end

  def index
    start_date = params['start_date'].present? ? DateTime.strptime(params['start_date'], '%Y%m%d') : DateTime.strptime('0', '%s')
    end_date = params['end_date'].present? ?  DateTime.strptime(params['end_date'], '%Y%m%d') : DateTime.strptime('3000', '%Y')
    if(params[:filter] == 'nuisance')
      ng_police_actions = PoliceAction.filtered_addresses.visible.suspicious.occurred_between(start_date, end_date).at_nuisance_property
      addrs = {}
      ng_police_actions.each do |n|
        if addrs[n.reverse_geocoded_address]
          addrs[n.reverse_geocoded_address] += 1
        else
          addrs[n.reverse_geocoded_address] = 1
        end
      end
      @police_actions = ng_police_actions.select{|n| addrs[n.reverse_geocoded_address] > 2}

    else
      @police_actions = PoliceAction.filtered_addresses.visible.suspicious.occurred_between start_date, end_date
    end
  end

  def hot_spots
    @hot_spots = PoliceAction.count(:all, :group => :reverse_geocoded_address).sort_by {|arr| -arr[1]}
  end

  def nuisance_properties
    @police_actions = PoliceAction.filtered_addresses.visible.suspicious.occurred_between(1.month.ago, DateTime.now).having('COUNT(*) > 2').count(:all, :group => :reverse_geocoded_address)
  end

end
