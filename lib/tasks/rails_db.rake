namespace :db do

  # Prevent dropping Production DB
  # ... or terminate postgres connections before attempting to drop in non production environment
  task :drop => [:abort_in_production, :terminate_pg]

  task :abort_in_production => :environment do
    abort "Can't drop #{Rails.env} DB!" if Rails.env.production?
  end

  # http://stackoverflow.com/questions/5108876/kill-a-postgresql-session-connection
  desc "Fix 'database is being accessed by other users'"
  task :terminate_pg => :environment do
    ActiveRecord::Base.connection.execute <<-SQL
      SELECT
        pg_terminate_backend(pid)
      FROM
        pg_stat_activity
      WHERE
        -- don't kill my own connection!
        pid <> pg_backend_pid()
        -- don't kill the connections to other databases
        AND datname = '#{ActiveRecord::Base.connection.current_database}';
    SQL
  end

end
