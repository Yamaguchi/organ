# frozen_string_literal: true

module Organ
  class EntityPrivilege < Entity
    belongs_to :role

    def access_level_of(access_right)
      case access_right
      when Organ::AccessRight::READ
        read_access
      when Organ::AccessRight::CREATE
        create_access
      when Organ::AccessRight::UPDATE
        update_access
      when Organ::AccessRight::DELETE
        delete_access
      else
        raise 'invalid access right'
      end
    end
  end
end
