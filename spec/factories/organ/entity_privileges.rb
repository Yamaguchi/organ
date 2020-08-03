# frozen_string_literal: true

FactoryBot.define do
  factory :entity_privilege, class: Organ::EntityPrivilege do
    read_access { Organ::AccessLevel::NONE }
    create_access { Organ::AccessLevel::NONE }
    update_access { Organ::AccessLevel::NONE }
    delete_access { Organ::AccessLevel::NONE }

    trait :global do
      read_access { Organ::AccessLevel::GLOBAL }
      create_access { Organ::AccessLevel::GLOBAL }
      update_access { Organ::AccessLevel::GLOBAL }
      delete_access { Organ::AccessLevel::GLOBAL }
    end

    trait :deep do
      read_access { Organ::AccessLevel::DEEP }
      create_access { Organ::AccessLevel::DEEP }
      update_access { Organ::AccessLevel::DEEP }
      delete_access { Organ::AccessLevel::DEEP }
    end

    trait :local do
      read_access { Organ::AccessLevel::LOCAL }
      create_access { Organ::AccessLevel::LOCAL }
      update_access { Organ::AccessLevel::LOCAL }
      delete_access { Organ::AccessLevel::LOCAL }
    end

    trait :basic do
      read_access { Organ::AccessLevel::BASIC }
      create_access { Organ::AccessLevel::BASIC }
      update_access { Organ::AccessLevel::BASIC }
      delete_access { Organ::AccessLevel::BASIC }
    end
  end
end
