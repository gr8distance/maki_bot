require './lib/models/base'

class Ask < Base
  validates_presence_of :question, :answer

  def prepare_save!
    self.id = question + '/' + answer
  end

  class << self
    # FIXME: 一致度を判定するメソッドに仕上げる
    def me_anything(question)
      where(question: question)
    end
  end
end
