require 'active_record'

class Base < ActiveRecord::Base
  establish_connection(ENV['DATABASE_URL'])
  self.abstract_class = true

  def prepare_save!
    nil
  end
end
