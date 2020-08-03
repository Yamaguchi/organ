# frozen_string_literal: true

module Organ
  class RoleUser < Entity
    belongs_to :role
    belongs_to :user
  end
end
