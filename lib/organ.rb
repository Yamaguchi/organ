# frozen_string_literal: true

require 'ancestry'
require 'organ/version'

module Organ
  class Error < StandardError; end

  autoload :Entity, 'organ/entity'
  autoload :EntityExt, 'organ/entity_ext'
  autoload :Party, 'organ/party'
  autoload :User, 'organ/User'
  autoload :OrganizationUnit, 'organ/organization_unit'
  autoload :Owner, 'organ/owner'
  autoload :Role, 'organ/role'
  autoload :Team, 'organ/team'
  autoload :TeamUser, 'organ/team_user'
  autoload :RoleUser, 'organ/role_user'
  autoload :RolePriviledge, 'organ/role_priviledge'
  autoload :Permission, 'organ/permission'
  autoload :AccessLevel, 'organ/access_level'
  autoload :EntityAccessContext, 'organ/entity_access_context'
  autoload :EntityAccessQueryContext, 'organ/entity_access_context'
  autoload :EntityAccessRule, 'organ/entity_access_rule'
  autoload :AccessRight, 'organ/access_right'
  autoload :AccessLevel, 'organ/access_level'
  autoload :EntityPrivilege, 'organ/entity_privilege'
  autoload :Repository, 'organ/repository'

  class PermissionDenied < StandardError
  end

  begin
    class Railtie < ::Rails::Railtie
      rake_tasks do
        load 'tasks/organ.rake'
      end
    end
  rescue LoadError
    puts 'Rake task is unavailable'
  end
end
