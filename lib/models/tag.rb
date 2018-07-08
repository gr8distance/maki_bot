require './lib/models/base'

class Tag < Base
  has_many :serifs, primary_key: :name, foreign_key: :tag_id

  def lottery_weight
    ::Weight::Lottery.execute(serifs)
  end
end
