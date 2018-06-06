require 'pry'
require './db/migrate'
require './lib/models/serif'
require './lib/models/ask'
require './lib/csv/all_importer'
require './lib/models/active_channel'
require './lib/models/tag'

namespace :db do
  desc 'DBのマイグレーション'
  task :migrate do
    migrate_all
  end

  desc 'DBの強制的なマイグレーション'
  task :migrate_reset do
    migrate_all(force: true)
  end

  desc 'DBの強制的なマイグレーションとCSVインポート'
  task :migrate_reset_csv do
    migrate_all(force: true)
    CSV::AllImporter.execute
  end
end

namespace :csv do
  task :import_all do
    CSV::AllImporter.execute
  end
end
