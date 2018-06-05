require 'pry'
require './lib/models/memo'
require './lib/models/serif'
require './lib/bot/notable'

module Bot
  class Base
    include Bot::Notable

    @@status = %i[bot librarian]

    attr_reader :name, :image
    attr_accessor :state
    def initialize
      # NOTE: 必要なら引数から受け取るようにする
      @name = ENV['BOT_NAME']
      @image = ENV['BOT_IMAGE']
      @state = :bot
    end

    def talk(emotion)
      serif = Serif.lottery_weight(emotion)
      serif&.text
    end

    @@status.each do |state|
      # NOTE: 現在の状態を確認するメソッド
      define_method "#{state}?".to_sym do
        @state == state
      end

      # NOTE: 現在の状態を変更するメソッド
      define_method "to_#{state}".to_sym do
        @state = state
      end
    end
  end
end
