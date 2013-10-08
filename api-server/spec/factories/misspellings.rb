# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :misspelling do
    wrong "MyText"
    correct "MyText"
  end
end
