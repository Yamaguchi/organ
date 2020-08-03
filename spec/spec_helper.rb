# frozen_string_literal: true

require 'active_record'
require 'bundler/setup'
require 'organ'
require 'support/factory_bot'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

def setup_database
  ::ActiveRecord::Base.logger = Logger.new('sql.log')

  ::ActiveRecord::Base.establish_connection({ adapter: 'sqlite3', database: 'test' })
  connection = ::ActiveRecord::Base.connection
  connection.create_table :teams, force: true do |t|
    t.string :name

    t.belongs_to :owner
    t.timestamps
  end

  connection.create_table :team_users, force: true do |t|
    t.belongs_to :user
    t.belongs_to :team
    t.timestamps
  end

  connection.create_table :users, force: true do |t|
    t.string :name
    t.belongs_to :organization_unit, null: false

    t.belongs_to :owner
    t.timestamps
  end

  connection.create_table :entity_privileges do |t|
    t.belongs_to :role
    t.string :entity_name
    t.integer :read_access
    t.integer :create_access
    t.integer :update_access
    t.integer :delete_access

    t.belongs_to :owner
    t.timestamps
  end

  connection.create_table :role_users do |t|
    t.belongs_to :role
    t.belongs_to :user
    t.timestamps
  end

  connection.create_table :roles do |t|
    t.string :name

    t.belongs_to :owner
    t.timestamps
  end

  connection.create_table :organization_units do |t|
    t.string :name
    t.string :ancestry, index: true

    t.belongs_to :owner
    t.timestamps
  end
end

def teardown_database
  connection = ::ActiveRecord::Base.connection
  connection.drop_table :teams, if_exists: true
  connection.drop_table :team_users, if_exists: true
  connection.drop_table :users, if_exists: true
  connection.drop_table :entity_privileges, if_exists: true
  connection.drop_table :role_users, if_exists: true
  connection.drop_table :roles, if_exists: true
  connection.drop_table :organization_units, if_exists: true
end
