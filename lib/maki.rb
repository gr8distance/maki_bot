require 'pry'
require './lib/models/memo'
require './lib/models/serif'

class Maki
  attr_reader :name, :image
  attr_accessor :mode
  def initialize
    @name = ENV['BOT_NAME']
    @image = ENV['BOT_IMAGE']
    @mode = 'bot'
  end

  def say(emotion)
    serif = Serif.lottery_weight(emotion)
    serif&.text
  end

  def add_note(text)
    if librarian?
      memo.body += text
    end
  end

  def bot?
    mode == 'bot'
  end

  def librarian?
    mode == 'librarian'
  end

  def memo
    @memo ||= Memo.new(body: '')
  end
end
