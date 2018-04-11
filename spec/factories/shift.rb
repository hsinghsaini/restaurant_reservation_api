FactoryBot.define do
  factory :shift1, class: Shift do|f|
    f.name "Morning"
    f.start "9:00"
    f.end "13:00"
    association :restaurant, factory: :restaurant
  end

  factory :shift2, class: Shift do|f|
    f.name "Evening"
    f.start "18:00"
    f.end "23:00"
    association :restaurant, factory: :restaurant
  end
end
