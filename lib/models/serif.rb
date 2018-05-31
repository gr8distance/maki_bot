require './lib/models/base'

class Serif < Base
  validates_presence_of :id, :text, :tag_id, :weight
  belongs_to :tag

  before_validation do
    self.id = text + '/' + tag_id
  end

  def prepare_save!
    self.id = text + '/' + tag_id
  end

  class << self
    def lottery_weight(tag)
      ::Weight::Lottery.execute(where(tag_id: tag))
    end
  end
end
