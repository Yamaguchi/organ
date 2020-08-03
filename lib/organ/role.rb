# frozen_string_literal: true

module Organ
  class Role < Entity
    has_many :role_users
    has_many :users, through: :role_users
    has_many :entity_privileges

    def self.supported_entities
      [User, OrganizationUnit, Team, Role, EntityPrivilege]
    end
  end
end
