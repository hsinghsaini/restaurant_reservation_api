FactoryBot.define do
  factory :reservation do|f|
    f.time "11:00"
    f.guest_count 4
  end
end
