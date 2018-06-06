require './lib/models/base'

class Tag < Base
  has_many :serifs

  def lottery_weight
    ::Weight::Lottery.execute(serifs)
  end
end
