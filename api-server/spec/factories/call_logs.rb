# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :call_log do
    for_date "2013-10-08"
    filename "MyString"
  end
end
