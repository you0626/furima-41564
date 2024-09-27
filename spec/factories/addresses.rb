FactoryBot.define do
  factory :address do
    order { nil }
    address { "MyString" }
    prefecture { "MyString" }
    postal_code { "MyString" }
    city { "MyString" }
    phone_number { "MyString" }
  end
end
