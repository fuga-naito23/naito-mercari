FactoryBot.define do
  factory :image do
    image {File.new("#{Rails.root}/spec/files/sample.png")}
  end
end
