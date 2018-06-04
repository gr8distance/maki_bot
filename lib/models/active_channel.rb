require './lib/models/base'

class ActiveChannel < Base
  validates_presence_of :id, :name
end
