FactoryBot.define do
  factory :article do
    sequence :preview do |n|
      "Preview #{n}"
    end

    sequence :description do |n|
      "Description #{n}"
    end
    author { create :user }
  end
end
