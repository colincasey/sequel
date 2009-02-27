module Sequel
  module MSAccess
    module DatabaseMethods
      AUTO_INCREMENT = 'COUNTER(1,1)'.freeze
      SQL_BEGIN = "BEGIN TRANSACTION".freeze
      SQL_COMMIT = "COMMIT TRANSACTION".freeze
      SQL_ROLLBACK = "ROLLBACK TRANSACTION".freeze

      def auto_increment_sql
        AUTO_INCREMENT
      end

      def dataset(opts = nil)
        ds = super
        ds.extend(DatasetMethods)
        ds
      end

      def tables
        self[:MSysObjects].select(:Name).filter({:Type => 1, :Flags => 0} | {:Type => 6}).collect { |result| result[:Name] }
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
