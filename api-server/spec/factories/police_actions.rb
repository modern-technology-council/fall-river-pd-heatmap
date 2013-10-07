# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :police_action do
    lat 1.5
    lon 1.5
    description "MyText"
    display_address "MyText"
    address "MyText"
    action_datetime "2013-10-07 17:28:50"
  end
end
