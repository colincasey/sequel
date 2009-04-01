require 'sequel_core/adapters/utils/unsupported'

module Sequel
  module MSAccess
    module DatabaseMethods
      AUTO_INCREMENT = 'COUNTER(1,1)'.freeze
      SQL_BEGIN = "BEGIN TRANSACTION".freeze
      SQL_COMMIT = "COMMIT TRANSACTION".freeze
      SQL_ROLLBACK = "ROLLBACK TRANSACTION".freeze

      AD_SCHEMA_TABLES  = 20
      AD_SCHEMA_COLUMNS = 4
      AD_SCHEMA_INDEXES = 12

      def auto_increment_sql
        AUTO_INCREMENT
      end

      def dataset(opts = nil)
        ds = super
        ds.extend(DatasetMethods)
        ds
      end

      def tables
        synchronize(opts[:server]) do |conn|
          schema = conn.OpenSchema(AD_SCHEMA_TABLES)
          unless schema.eof
            schema.moveFirst
            m_sys_objects = schema.getRows.transpose.extend(Enumerable).collect { |mso| MSysObject.new(*mso) }
          end
          schema.Close
          tables = m_sys_objects.select { |mso| mso.table?  }
          tables.collect { |table| table.name }
        end
      end

      def columns(table)
        synchronize(opts[:server]) do |conn|
          schema = conn.OpenSchema(AD_SCHEMA_COLUMNS, [nil, nil, table.to_s])
          result_columns = schema.Fields.extend(Enumerable).map do |column|
            column.Name.empty? ? '(no column name)' : column.Name
          end

          columns = []
          unless schema.eof
            schema.moveFirst
            schema.getRows.transpose.each do |row|
              columns << result_columns.inject({}) do |hash, col|
                hash[col] = row.shift
                hash
              end
            end
          end

          schema.Close
          columns
        end
      end
      
      def indexes(table)
        synchronize(opts[:server]) do |conn|
          schema = conn.OpenSchema(AD_SCHEMA_INDEXES, [nil, nil, nil, nil, table.to_s])
          result_columns = schema.Fields.extend(Enumerable).map do |column|
            column.Name.empty? ? '(no column name)' : column.Name
          end

          indexes = []
          unless schema.eof
            schema.moveFirst
            schema.getRows.transpose.each do |row|
              indexes << result_columns.inject({}) do |hash, col|
                hash[col] = row.shift
                hash
              end
            end
          end

          schema.Close
          indexes
        end
      end

      def primary_key(table)
        keys = indexes(table).collect do |index|
          index["COLUMN_NAME"] if index["PRIMARY_KEY"] == true
        end
        
        case keys.length
        when 0 then nil
        when 1 then keys.first
        else keys
        end
      end

      def upcase_identifiers?
        false
      end

      def identifier_output_method
        nil
      end

      private
      # SQL to BEGIN a transaction.
      def begin_transaction_sql
        SQL_BEGIN
      end

      # SQL to COMMIT a transaction.
      def commit_transaction_sql
        SQL_COMMIT
      end

      # SQL to ROLLBACK a transaction.
      def rollback_transaction_sql
        SQL_ROLLBACK
      end

      class MSysObject < Struct.new(:catalog, :schema, :name, :type, :guid, :description, :prop_id, :date_created, :date_modified)
        def table?
          type == "TABLE"
        end

        def linked?
          type == "LINK"
        end

        def system?
          type == "SYSTEM TABLE"
        end
      end

      class AdoIndex < Struct.new(:prop_id, :guid, :ordinal_position, :nulls, :index_catalog, :table_catalog, :filter_condition,
          :name, :auto_update, :pages, :fill_factor, :type, :null_collation, :unique, :primary_key, :cardinality, :clustered,
          :index_schema, :table_schema, :integrated, :collation, :column_name, :sort_bookmarks, :initial_size, :table_name)
        alias_method :auto_update?,    :auto_update
        alias_method :unique?,         :unique
        alias_method :primary_key?,    :primary_key
        alias_method :clustered?,      :clustered
        alias_method :integrated?,     :integrated
        alias_method :sort_bookmarks?, :sort_bookmarks
      end
    end

    module DatasetMethods
      include Dataset::UnsupportedIntersectExcept

      SELECT_CLAUSE_ORDER = %w'limit distinct columns from with join where group order having union'.freeze

      def complex_expression_sql(op, args)
        case op
        when :'||'
          super(:+, args)
        else
          super(op, args)
        end
      end

      def full_text_search(cols, terms, opts = {})
        filter("CONTAINS (#{literal(cols)}, #{literal(terms)})")
      end

      def literal(v)
        case v
        when Time
          literal(v.iso8601)
        when Date, DateTime
          literal(v.to_s)
        when TrueClass
          'TRUE'
        when FalseClass
          'FALSE'
        else
          super
        end
      end

      def multi_insert_sql(columns, values)
        values = values.map {|r| "SELECT #{expression_list(r)}" }.join(" UNION ALL ")
        ["INSERT INTO #{source_list(@opts[:from])} (#{identifier_list(columns)}) #{values}"]
      end

      # Allows you to do .nolock on a query
      def nolock
        clone(:with => "(NOLOCK)")
      end

      def quoted_identifier(name)
        "[#{name}]"
      end

      private
      def select_clause_order
        SELECT_CLAUSE_ORDER
      end

      # ACCESS uses TOP for limit, with no offset support
      def select_limit_sql(sql, opts)
        raise(Error, "OFFSET not supported") if opts[:offset]
        sql << " TOP #{opts[:limit]}" if opts[:limit]
      end

      # MSSQL uses the WITH statement to lock tables
      def select_with_sql(sql, opts)
        sql << " WITH #{opts[:with]}" if opts[:with]
      end

      def select_union_sql(sql, opts)
        sql << " UNION #{opts[:union]}" if opts[:union]
      end      
    end
  end
end
