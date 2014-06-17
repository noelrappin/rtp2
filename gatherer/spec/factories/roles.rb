# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :role do
    user nil
    project nil
    role_name "MyString"
  end
end
