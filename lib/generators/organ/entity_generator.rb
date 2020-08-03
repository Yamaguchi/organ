module Organ
  class EntityGenerator < Rails::Generators::NamedBase
    include ::Rails::Generators::Migration

    source_root File.expand_path('templates', __dir__)

    def self.next_migration_number(dirname)
      next_migration_number = current_migration_number(dirname) + 1
      ::ActiveRecord::Migration.next_migration_number(next_migration_number)
    end

    def create_migration_file
      template = file_name
      migration_dir = File.expand_path('db/migrate')

      if self.class.migration_exists?(migration_dir, template)
        ::Kernel.warn "Migration already exists: #{template}"
      else
        migration_template(
          "#{template}.rb.erb",
          "db/migrate/create_#{template}.rb",
          migration_version: migration_version,
          table_options: table_options
        )
      end
    end

    MYSQL_ADAPTERS = [
      'ActiveRecord::ConnectionAdapters::MysqlAdapter',
      'ActiveRecord::ConnectionAdapters::Mysql2Adapter'
    ].freeze

    private

    def migration_version
      major = ::Rails::VERSION::MAJOR
      "[#{major}.#{::Rails::VERSION::MINOR}]" if major >= 5
    end

    def mysql?
      MYSQL_ADAPTERS.include?(::ActiveRecord::Base.connection.class.name)
    end

    def table_options
      if mysql?
        ', { options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci" }'
      else
        ''
      end
    end
  end
end
