# frozen_string_literal: true

module Organ
  class TeamUser < Entity
    belongs_to :team
    belongs_to :user
  end
end
