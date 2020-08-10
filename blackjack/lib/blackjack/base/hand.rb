module Blackjack
  module Base
    class Hand
      def initialize(name)
        @name = name
        @cards = []
      end

      attr_reader :name, :cards

      def <<(card)
        @cards << card
      end

      def reveal
        @cards.each(&:reveal)
        self
      end

      def value
        raise NotImplementedError
      end
    end
  end
end