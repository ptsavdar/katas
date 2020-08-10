module Blackjack
  module Base
    class Deck
      def initialize
        @cards = build_deck
        @index = 0
      end

      def next
        raise 'No cards left in deck' unless next?

        @index += 1
        cards[index - 1]
      end

      def next?
        index < cards.size
      end

      def next_revealed
        self.next.reveal
      end

      private

      attr_accessor :cards, :index

      def build_deck
        Card::SUITS.reduce([]) do |cards, suit|
          cards.concat((1..13).map { |rank| Card.new(rank, suit) })
        end.shuffle
      end
    end
  end
end