FactoryBot.define do
  factory :item do
    title { Faker::Commerce.product_name }
    explanation { Faker::Lorem.paragraph }
    category_id { 1 }
    state_id { 1 }
    spirit_id { 1 }
    prefecture_id { 1 }
    day_id { 1 }
    price { Faker::Number.between(from: 300, to: 9_999_999) }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('spec/factories/test_image.png'), filename: 'test_image.png', content_type: 'image/png')
    end
  end
end
