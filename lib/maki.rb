require 'pry'

require './lib/string'
require './lib/bot/base'

class Maki < Bot::Base
  def with_face(*word)
    if word.empty?
      '从廿_廿从'
    else
      '从廿_廿从' + ' < ' + word.join('、')
    end
  end

  def suggest_song
    classic_songs.sample
  end

  private

  def classic_songs
    %w[愛の夢 月の光 月光 雨だれ Etude25-10]
  end
end

maki = Maki.new
binding.pry
