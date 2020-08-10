module Blackjack
  class BlackjackHand < Base::Hand
    def value
      result = count_cards
      ace? && result < 12 ? result + 10 : result
    end

    def busted?
      value > 21
    end

    def blackjack?
      value == 21 && cards.count == 2
    end

    def stand
      @stand = true
    end

    def active?
      !@stand && value < 21
    end

    def to_s
      "#{name} hand: #{cards.join(',')} Score: #{value}"
    end

    private

    def ace?
      @ace ||= cards.any? { |card| card.rank == 1 } # here we could implement a BJ card class that could tell us if card is ace
    end

    def count_cards
      cards.reduce(0) { |val, card| val + [10, card.revealed? ? card.rank : 0].min }
    end
  end
end