require './lib/models/base'

class Serif < Base
  validates_presence_of :id, :text, :tag_id
  belongs_to :tag

  before_validation do
    self.id = text + '/' + tag_id
  end
end
