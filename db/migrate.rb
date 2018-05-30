require 'active_record'

ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'])

def migrate_all(force: false)
  ActiveRecord::Migration.create_table(:serifs, force: force, id: false) do |t|
    t.string :id, primary_key: true
    t.string :text, null: false, default: ''
    t.string :tag_id, null: false

    t.timestamps
  end

  ActiveRecord::Migration.create_table(:tags, force: force, id: false) do |t|
    t.string :id, primary_key: true
    t.integer :weight, null: false

    t.timestamps
  end
end
