# frozen_string_literal: true

module Organ
  class RoleEntityPrivilege < Entity
    belongs_to :role
    belongs_to :entity_privilege
  end
end
