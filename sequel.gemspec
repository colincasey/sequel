Gem::Specification.new do |s|
  s.name = 'sequel'
  s.rubyforge_project = 'sequel'
  s.version = '2.10.1'
  s.platform = Gem::Platform::RUBY
  s.has_rdoc = true
  s.extra_rdoc_files = ["README.rdoc", "CHANGELOG", "COPYING",
    "doc/cheat_sheet.rdoc", "doc/advanced_associations.rdoc", "doc/sharding.rdoc",
    "doc/prepared_statements.rdoc", "doc/dataset_filtering.rdoc", "doc/schema.rdoc",
    "doc/release_notes/2.8.0.txt", "doc/release_notes/2.0.0.txt", "doc/release_notes/2.1.0.txt",
    "doc/release_notes/2.9.0.txt", "doc/release_notes/2.4.0.txt", "doc/release_notes/1.1.txt",
    "doc/release_notes/2.3.0.txt", "doc/release_notes/1.0.txt", "doc/release_notes/2.2.0.txt",
    "doc/release_notes/1.4.0.txt", "doc/release_notes/2.5.0.txt", "doc/release_notes/1.5.0.txt",
    "doc/release_notes/2.10.0.txt", "doc/release_notes/1.3.txt", "doc/release_notes/2.7.0.txt",
    "doc/release_notes/2.6.0.txt"]
  s.rdoc_options += ["--quiet", "--line-numbers", "--inline-source", '--title',
    'Sequel: The Database Toolkit for Ruby', '--main', 'README.rdoc']
  s.summary = "The Database Toolkit for Ruby"
  s.description = s.summary
  s.author = "Jeremy Evans"
  s.email = "code@jeremyevans.net"
  s.homepage = "http://sequel.rubyforge.org"
  s.required_ruby_version = ">= 1.8.4"
  s.files = ["COPYING", "CHANGELOG", "README.rdoc", "Rakefile", "bin/sequel", "doc/release_notes",
    "doc/release_notes/2.8.0.txt", "doc/release_notes/2.0.0.txt", "doc/release_notes/2.1.0.txt",
    "doc/release_notes/2.9.0.txt", "doc/release_notes/2.4.0.txt", "doc/release_notes/1.1.txt",
    "doc/release_notes/2.3.0.txt", "doc/release_notes/1.0.txt", "doc/release_notes/2.2.0.txt",
    "doc/release_notes/1.4.0.txt", "doc/release_notes/2.5.0.txt", "doc/release_notes/1.5.0.txt",
    "doc/release_notes/2.10.0.txt", "doc/release_notes/1.3.txt", "doc/release_notes/2.7.0.txt",
    "doc/release_notes/2.6.0.txt", "doc/cheat_sheet.rdoc", "doc/advanced_associations.rdoc",
    "doc/sharding.rdoc", "doc/prepared_statements.rdoc", "doc/dataset_filtering.rdoc",
    "doc/schema.rdoc", "spec/spec_config.rb.example", "spec/integration",
    "spec/integration/eager_loader_test.rb", "spec/integration/prepared_statement_test.rb",
    "spec/integration/schema_test.rb", "spec/integration/dataset_test.rb",
    "spec/integration/spec_helper.rb", "spec/integration/type_test.rb", "spec/spec.opts",
    "spec/adapters", "spec/adapters/sqlite_spec.rb", "spec/adapters/informix_spec.rb",
    "spec/adapters/firebird_spec.rb", "spec/adapters/postgres_spec.rb", "spec/adapters/oracle_spec.rb",
    "spec/adapters/mysql_spec.rb", "spec/adapters/spec_helper.rb", "spec/adapters/ado_spec.rb",
    "spec/sequel_model", "spec/sequel_model/hooks_spec.rb", "spec/sequel_model/eager_loading_spec.rb",
    "spec/sequel_model/associations_spec.rb", "spec/sequel_model/association_reflection_spec.rb",
    "spec/sequel_model/inflector_spec.rb", "spec/sequel_model/caching_spec.rb",
    "spec/sequel_model/model_spec.rb", "spec/sequel_model/validations_spec.rb",
    "spec/sequel_model/base_spec.rb", "spec/sequel_model/record_spec.rb",
    "spec/sequel_model/spec_helper.rb", "spec/sequel_model/schema_spec.rb",
    "spec/sequel_model/dataset_methods_spec.rb", "spec/sequel_model/plugins_spec.rb",
    "spec/sequel_core", "spec/sequel_core/version_spec.rb", "spec/sequel_core/dataset_spec.rb",
    "spec/sequel_core/pretty_table_spec.rb", "spec/sequel_core/object_graph_spec.rb",
    "spec/sequel_core/migration_spec.rb", "spec/sequel_core/expression_filters_spec.rb",
    "spec/sequel_core/database_spec.rb", "spec/sequel_core/core_sql_spec.rb",
    "spec/sequel_core/connection_pool_spec.rb", "spec/sequel_core/schema_generator_spec.rb",
    "spec/sequel_core/spec_helper.rb", "spec/sequel_core/schema_spec.rb",
    "spec/sequel_core/core_ext_spec.rb", "spec/rcov.opts", "lib/sequel_model.rb",
    "lib/sequel_core.rb", "lib/sequel_model", "lib/sequel_model/dataset_methods.rb",
    "lib/sequel_model/hooks.rb", "lib/sequel_model/schema.rb", "lib/sequel_model/associations.rb",
    "lib/sequel_model/plugins.rb", "lib/sequel_model/eager_loading.rb",
    "lib/sequel_model/association_reflection.rb", "lib/sequel_model/record.rb",
    "lib/sequel_model/exceptions.rb", "lib/sequel_model/caching.rb", "lib/sequel_model/base.rb",
    "lib/sequel_model/inflector.rb", "lib/sequel_model/validations.rb", "lib/sequel_core",
    "lib/sequel_core/migration.rb", "lib/sequel_core/sql.rb", "lib/sequel_core/version.rb",
    "lib/sequel_core/schema.rb", "lib/sequel_core/dataset", "lib/sequel_core/dataset/unsupported.rb",
    "lib/sequel_core/dataset/stored_procedures.rb", "lib/sequel_core/dataset/query.rb",
    "lib/sequel_core/dataset/sql.rb", "lib/sequel_core/dataset/schema.rb",
    "lib/sequel_core/dataset/callback.rb", "lib/sequel_core/dataset/pagination.rb",
    "lib/sequel_core/dataset/convenience.rb", "lib/sequel_core/dataset/prepared_statements.rb",
    "lib/sequel_core/adapters", "lib/sequel_core/adapters/openbase.rb",
    "lib/sequel_core/adapters/firebird.rb", "lib/sequel_core/adapters/oracle.rb",
    "lib/sequel_core/adapters/sqlite.rb", "lib/sequel_core/adapters/postgres.rb",
    "lib/sequel_core/adapters/db2.rb", "lib/sequel_core/adapters/do",
    "lib/sequel_core/adapters/do/sqlite.rb", "lib/sequel_core/adapters/do/postgres.rb",
    "lib/sequel_core/adapters/do/mysql.rb", "lib/sequel_core/adapters/informix.rb",
    "lib/sequel_core/adapters/dbi.rb", "lib/sequel_core/adapters/jdbc",
    "lib/sequel_core/adapters/jdbc/oracle.rb", "lib/sequel_core/adapters/jdbc/sqlite.rb",
    "lib/sequel_core/adapters/jdbc/h2.rb", "lib/sequel_core/adapters/jdbc/mysql.rb",
    "lib/sequel_core/adapters/jdbc/postgresql.rb", "lib/sequel_core/adapters/do.rb",
    "lib/sequel_core/adapters/shared", "lib/sequel_core/adapters/shared/oracle.rb",
    "lib/sequel_core/adapters/shared/sqlite.rb", "lib/sequel_core/adapters/shared/postgres.rb",
    "lib/sequel_core/adapters/shared/mssql.rb", "lib/sequel_core/adapters/shared/progress.rb",
    "lib/sequel_core/adapters/shared/mysql.rb", "lib/sequel_core/adapters/shared/ms_access.rb",
    "lib/sequel_core/adapters/ado.rb", "lib/sequel_core/adapters/mysql.rb",
    "lib/sequel_core/adapters/odbc.rb", "lib/sequel_core/adapters/jdbc.rb",
    "lib/sequel_core/exceptions.rb", "lib/sequel_core/connection_pool.rb",
    "lib/sequel_core/core_sql.rb", "lib/sequel_core/schema", "lib/sequel_core/schema/sql.rb",
    "lib/sequel_core/schema/generator.rb", "lib/sequel_core/dataset.rb",
    "lib/sequel_core/object_graph.rb", "lib/sequel_core/database",
    "lib/sequel_core/database/schema.rb", "lib/sequel_core/deprecated.rb",
    "lib/sequel_core/core_ext.rb", "lib/sequel_core/pretty_table.rb", "lib/sequel_core/database.rb",
    "lib/sequel.rb"]
  s.require_path = "lib"
  s.bindir = 'bin'
  s.executables << 'sequel'
end