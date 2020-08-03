# frozen_string_literal: true

module Organ
  class Entity < ActiveRecord::Base
    include Organ::Owner
    self.abstract_class = true
  end
end
