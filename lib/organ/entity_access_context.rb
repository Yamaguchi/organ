# frozen_string_literal: true

module Organ
  class EntityAccessContext
    attr_accessor :entity, :access_type, :user
    # @param [Organ::AccessRight] access_type
    def initialize(entity, access_type, user)
      @entity = entity
      @access_type = access_type
      @user = user
    end
  end

  class EntityAccessQueryContext
    attr_accessor :entity_type, :access_type, :user

    # @param [Organ::AccessRight] access_type
    def initialize(entity_type, access_type, user)
      @entity_type = entity_type
      @access_type = access_type
      @user = user
    end
  end
end
