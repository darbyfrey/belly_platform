task :environment do
  require 'erb'  
  require './app'
end

namespace :db do
  desc "Migrate the database through scripts in db/migrate. Target specific version with VERSION=x"
  task :migrate => :environment do
    ActiveRecord::Migrator.migrate('db/migrate', ENV["VERSION"] ? ENV["VERSION"].to_i : nil )
  end

  desc "Create the database"
  task :create => :environment do
    db = YAML.load(ERB.new(File.read('./config/database.yml')).result)[BellyPlatform.env]
    admin = db.merge({'database'=> 'mysql'})
    ActiveRecord::Base.establish_connection(admin)
    ActiveRecord::Base.connection.create_database(db.fetch('database'))
  end

  desc "Delete the database"
  task :drop => :environment do
    db = YAML.load(ERB.new(File.read('./config/database.yml')).result)[BellyPlatform.env]
    admin = db.merge({'database'=> 'mysql'})
    ActiveRecord::Base.establish_connection(admin)
    ActiveRecord::Base.connection.drop_database(db.fetch('database'))
  end

  namespace :generate do
    desc "Generate a migration with given name. Specify migration name with NAME=my_migration_name"
    task :migration => :environment do
      raise "Please specify desired migration name with NAME=my_migration_name" unless ENV['NAME']
      
      # Find migration name from env
      migration_name = ENV['NAME'].strip.chomp
      
      # Define migrations path (needed later)
      migrations_path = './db/migrate'
            
      # Find the highest existing migration version or set to 1
      if (existing_migrations = Dir[File.join(migrations_path, '*.rb')]).length > 0
        version = File.basename(existing_migrations.sort.reverse.first)[/^(\d+)_/,1].to_i + 1
      else
        version = 1
      end
      
      # Read the contents of the migration template into string
      migrations_template = File.read(File.join(migrations_path, 'migration.template') )
      
      # Replace the migration name in template with the acutal one
      migration_content = migrations_template.gsub('__migration_name__', migration_name.camelize)
      
      # Generate migration filename
      migration_filename = "#{"%03d" % version}_#{migration_name}.rb"
      
      # Write the migration
      File.open(File.join(migrations_path, migration_filename), "w+") do |migration|
        migration.puts migration_content
      end
      
      # Done!
      puts "Successfully created migration #{migration_filename}"
    end
  end
  
  namespace :schema do
    desc "Create a db/schema.rb file that can be portably used against any DB supported by AR"
    task :dump => :environment do
      require 'active_record/schema_dumper'
      File.open(ENV['SCHEMA'] || "db/schema.rb", "w") do |file|
        ActiveRecord::SchemaDumper.dump(ActiveRecord::Base.connection, file)
      end
    end
 
    desc "Load a schema.rb file into the database"
    task :load => :environment do
      file = ENV['SCHEMA'] || "db/schema.rb"
      load(file)
    end
  end
end
