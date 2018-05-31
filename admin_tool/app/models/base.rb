class Base < ActiveRecord::Base
  establish_connection(:maki_db)
  self.abstract_class = true
end
