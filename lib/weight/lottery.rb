require 'active_support'
require './lib/weight/item'
require 'pry'

module Weight
  class Lottery
    class << self
      def execute(items)
        total_weight = items.sum(&:weight)
        value = rand(1..total_weight + 1)
        index = -1
        items.length.times do |i|
          if items[i].weight >= value
            index = i
            break
          end
          value -= items[i].weight
        end
        items[index]
      end
    end
  end
end
