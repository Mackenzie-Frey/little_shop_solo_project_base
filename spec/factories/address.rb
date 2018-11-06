FactoryBot.define do
  factory :address, class: Address do
    sequence(:name) { |n| "Address #{n}" }
    sequence(:street_address) { |n| "Address #{n} st" }
    sequence(:city) { |n| "City #{n}" }
    sequence(:state) { |n| "State #{n}" }
    sequence(:zip) { |n| "Zip #{n}" }
    user
  end
end
