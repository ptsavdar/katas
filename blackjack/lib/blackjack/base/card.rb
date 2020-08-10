# frozen_string_literal: true

module Blackjack
  module Base
    class Card
      module Suits
        SPADES = 'A'
        HEARTS = 'B'
        DIAMONDS = 'C'
        CLUBS = 'D'

        def self.all
          [SPADES, HEARTS, DIAMONDS, CLUBS]
        end
      end

      SUITS = Suits.all.freeze
      RANKS = (1..13).to_a.freeze

      def initialize(rank, suit)
        raise 'Invalid rank' unless RANKS.include?(rank)
        raise 'Invalid suit' unless SUITS.include?(suit)

        @rank = rank
        @suit = suit
        @revealed = false
      end

      attr_reader :rank, :suit

      def revealed?
        revealed
      end

      def reveal
        @revealed = true
        self
      end

      def to_s
        return '🂠' unless revealed?

        "1f0#{suit}#{rank_code}".hex.chr('UTF-8')
      end

      private

      attr_accessor :revealed

      def rank_code
        return rank.to_s(16) if rank < 12

        (rank + 1).to_s(16)
      end
    end
  end
end