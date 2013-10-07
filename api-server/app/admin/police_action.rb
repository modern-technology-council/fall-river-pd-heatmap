ActiveAdmin.register PoliceAction do

  controller do
    def permitted_params
      params.permit(:police_action)
    end
  end
end
