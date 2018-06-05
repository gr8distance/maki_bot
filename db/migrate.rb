require 'active_record'

ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'])

def migrate_all(force: false)
  ActiveRecord::Migration.create_table(:serifs, force: force, id: false) do |t|
    t.string :id, primary_key: true
    t.string :text, null: false, default: ''
    t.string :tag_id, null: false
    t.integer :weight, null: false

    t.timestamps
  end

  ActiveRecord::Migration.create_table(:asks, force: force, id: false) do |t|
    t.string :id, primary_key: true
    t.string :question, null: false, unique: true
    t.string :answer, null: false

    t.timestamps
  end

  ActiveRecord::Migration.create_table(:memos, force: force) do |t|
    t.string :body

    t.timestamps
  end

  ActiveRecord::Migration.create_table(:active_channels, force: force, id: false) do |t|
    t.string :id, primary_key: true
    t.string :name

    t.timestamps
  end
end
