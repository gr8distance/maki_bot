require 'active_record'

class Base < ActiveRecord::Base
  establish_connection(ENV['DATABASE_URL'])
  self.abstract_class = true
end
