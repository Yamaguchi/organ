# frozen_string_literal: true

module Organ
  module Owner
    extend ActiveSupport::Concern

    included do
      belongs_to :owner, class_name: 'User'
    end
  end
end
