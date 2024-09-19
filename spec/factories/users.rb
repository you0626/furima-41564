FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.initials(number: 2) }
    email                 { Faker::Internet.email }
    password              { Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    first_name            { '山田' }
    last_name             { '太郎' }
    first_name_katakana   { 'ヤマダ' }
    last_name_katakana    { 'タロウ' }
    birth                 { '1990-01-01' }
  end
end
