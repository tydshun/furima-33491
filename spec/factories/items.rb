FactoryBot.define do
  factory :item do
    image { Faker::Lorem.sentence }
    name               { '商品名のテスト' }
    explanation        { '商品の説明のテスト' }
    category_id        { 2 }
    condition_id       { 2 }
    postage_type_id    { 2 }
    prefecture_id      { 2 }
    preparation_day_id { 2 }
    price              { 5000 }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image2.png'), filename: 'test_image2.png')
    end
  end
end
