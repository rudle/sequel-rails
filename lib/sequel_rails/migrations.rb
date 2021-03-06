require 'sequel/extensions/migration'

module SequelRails
  class Migrations
    class << self
      def migrate(version=nil)
        opts = {}
        opts[:target] = version.to_i if version
        ::Sequel::Migrator.run(::Sequel::Model.db, "db/migrate", opts)
      end
      alias_method :migrate_up!, :migrate
      alias_method :migrate_down!, :migrate

      def pending_migrations?
        return false unless File.exists?("db/migrate")
        !::Sequel::Migrator.is_current?(::Sequel::Model.db, "db/migrate")
      end
    end
  end
end
