class Serif < Base
  validates_presence_of :id, :text, :tag_id, :weight
  before_validation do
    self.id = text + '/' + tag_id
  end

  def prepare_save!
    self.id = text + '/' + tag_id
  end
end
