# frozen_string_literal: true

namespace :organ do
  desc 'initialize organ entity'
  task :install, [] => [:environment] do |_, _|
    Rails::Generators.invoke('organ:entity', ['organization_unit'])
    Rails::Generators.invoke('organ:entity', ['entity_privilege'])
    Rails::Generators.invoke('organ:entity', ['role_entity_privilege'])
    Rails::Generators.invoke('organ:entity', ['role_user'])
    Rails::Generators.invoke('organ:entity', ['role'])
    Rails::Generators.invoke('organ:entity', ['team_user'])
    Rails::Generators.invoke('organ:entity', ['team'])
    Rails::Generators.invoke('organ:entity', ['user'])
  end
end
