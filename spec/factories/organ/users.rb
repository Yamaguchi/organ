# frozen_string_literal: true

FactoryBot.define do
  factory :user, class: Organ::User do
    name { 'user' }
    organization_unit { build(:organization_unit) }
    after(:create) do |u|
      u.update(owner: u)
    end
  end
end
