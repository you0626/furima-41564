FactoryBot.define do
  factory :order_address do
    token { 'tok_abcdefghijk00000000000000000' }
    postal_code { '123-4567' }
    prefecture_id { 1 }
    municipality { '東京市' }
    house_number { '1-1' }
    building_name { 'テストマンション' }
    telephone_number { '09012345678' }
    user_id { 1 }
    item_id { 1 }

    trait :invalid do
      postal_code { '' }
    end
  end
end
