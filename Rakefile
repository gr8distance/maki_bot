require './db/migrate'

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
