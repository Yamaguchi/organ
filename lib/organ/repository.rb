# frozen_string_literal: true

module Organ
  module Repository
    def save(user, entity)
      raise Organ::PermissionDenied unless entity.class.name.demodulize == self.class::ENTITY_CLASS

      raise Organ::PermissionDenied unless user

      access_type = entity.new_record? ? Organ::AccessRight::CREATE : Organ::AccessRight::UPDATE
      ctx = EntityAccessContext.new(entity, access_type, user)
      raise Organ::PermissionDenied unless EntityAccessRule.satisfied_by?(ctx)

      entity.save
    end

    def destroy(user, entity)
      raise Organ::PermissionDenied unless entity.class.name.demodulize == self.class::ENTITY_CLASS

      raise Organ::PermissionDenied unless user

      ctx = EntityAccessContext.new(entity, Organ::AccessRight::DELETE, user)
      raise Organ::PermissionDenied unless EntityAccessRule.satisfied_by?(ctx)

      entity.destroy
    end

    def find(user, clazz, id)
      raise Organ::PermissionDenied unless user

      ctx = EntityAccessQueryContext.new(self.class::ENTITY_CLASS, Organ::AccessRight::READ, user)
      EntityAccessRule.select_satisfying(ctx, clazz).find(id)
    end

    def find_by(user, clazz, param)
      raise Organ::PermissionDenied unless user

      ctx = EntityAccessQueryContext.new(self.class::ENTITY_CLASS, Organ::AccessRight::READ, user)
      EntityAccessRule.select_satisfying(ctx, clazz).find_by(param)
    end

    def select(user, clazz)
      raise Organ::PermissionDenied unless user

      ctx = EntityAccessQueryContext.new(self.class::ENTITY_CLASS, Organ::AccessRight::READ, user)
      EntityAccessRule.select_satisfying(ctx, clazz)
    end
  end
end
