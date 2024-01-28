# frozen_string_literal: true

module CustomPostgresTypes
  class ULID < ActiveRecord::Type::Text
    def type
      :ulid
    end
  end
end

ActiveSupport.on_load(:active_record_postgresqladapter) do
  ActiveRecord::ConnectionAdapters::PostgreSQLAdapter::NATIVE_DATABASE_TYPES[:ulid] = { name: 'ulid' }
  ActiveRecord::ConnectionAdapters::PostgreSQLAdapter.singleton_class.prepend(Module.new do
    def initialize_type_map(type_map)
      type_map.register_type 'ulid', CustomPostgresTypes::ULID.new
      super
    end
  end)

  ActiveRecord::Type.register(:ulid, CustomPostgresTypes::ULID, adapter: :postgresql)
end
