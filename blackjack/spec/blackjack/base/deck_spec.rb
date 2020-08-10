RSpec.describe Blackjack::Base::Deck do
  subject(:deck) { described_class.new }

  describe '#creation' do
    it 'creates a 52 card deck' do
      expect(card_count).to eq(52)
    end

    # This has a 1/52 chance to fail - is a flaky one, but for now let's leave it like that
    it 'creates a shuffled deck' do
      new_deck = described_class.new

      expect(deck.next.reveal.to_s).not_to eq(new_deck.next.reveal.to_s)
    end
  end

  def card_count
    card_count = 0
    while deck.next?
      deck.next
      card_count += 1
    end
    card_count
  end
end