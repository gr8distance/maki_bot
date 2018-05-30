require './lib/models/base'

class Serif < Base
  validates_presence_of :id, :text
  before_validation do
    self.id = text + '/' + tag
  end
end
