# frozen_string_literal: true

module Organ
  class Team < Entity
    has_many :team_users
    has_many :users, through: :team_users
  end
end
