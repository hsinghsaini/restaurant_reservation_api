FactoryBot.define do
  factory :table1, class: Table do|f|
    f.name "T1"
    f.minimum_guests 1
    f.maximum_guests 4
    association :restaurant, factory: :restaurant
  end

  factory :table2, class: Table do|f|
    f.name "T2"
    f.minimum_guests 5
    f.maximum_guests 8
    association :restaurant, factory: :restaurant
  end
end
