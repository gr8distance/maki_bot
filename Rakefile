require 'pry'
require './db/migrate'
require './lib/models/serif.rb'
require './lib/csv/all_importer'

namespace :db do
  desc 'DBのマイグレーション'
  task :migrate do
    migrate_all
  end

  desc 'DBの強制的なマイグレーション'
  task :migrate_reset do
    migrate_all(force: true)
  end
end

namespace :csv do
  task :import_all do
    CSV::AllImporter.execute
  end
end
