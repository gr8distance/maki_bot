class Ask < Base
  validates_presence_of :id, :question, :answer

  def prepare_save!
    self.id = question + '/' + answer
  end
end
