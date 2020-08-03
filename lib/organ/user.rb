# frozen_string_literal: true

module Organ
  class User < Entity
    belongs_to :organization_unit
    has_many :role_users
    has_many :roles, through: :role_users

    after_create :reassign_owner

    private

    def reassign_owner
      update(owner: self)
    end
  end
end
