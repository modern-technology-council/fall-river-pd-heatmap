ActiveAdmin.register CallLog do
  form(:html => { :multipart => true }) do |f|
    f.inputs 'Call Log' do
      f.input :for_date
      f.input :filename, :as => :file
    end
    f.buttons
  end

end
