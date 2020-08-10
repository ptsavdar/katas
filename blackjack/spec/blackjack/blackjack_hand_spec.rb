RSpec.describe Blackjack::BlackjackHand do
  subject(:bj_hand) { described_class.new('Dealer') }

  let(:card_class) { Blackjack::Base::Card }

  describe '#value' do
    before do
      bj_hand << card_class.new(3, 'A')
      bj_hand << card_class.new(6, 'B')
    end

    it 'returns 0 when hand is not revealed' do
      expect(bj_hand.value).to eq(0)
    end

    it 'returns correct value when hand is revealed' do
      expect(bj_hand.reveal.value).to eq(9)
    end

    it 'returns correct value when hand contains a figure' do
      bj_hand << card_class.new(12, 'C')

      expect(bj_hand.reveal.value).to eq(19)
    end

    context 'when hand has Ace' do
      before do
        bj_hand << card_class.new(1, 'D')
      end

      it 'counts Ace as 11 when score is low' do
        expect(bj_hand.reveal.value).to eq(20)
      end

      it 'counts Ace as 1 when score is high' do
        bj_hand << card_class.new(4, 'A')
        expect(bj_hand.reveal.value).to eq(14)
      end

      it 'counts second Ace as 1' do
        bj_hand << card_class.new(1, 'A')
        expect(bj_hand.reveal.value).to eq(21)
      end
    end
  end

  describe '#busted?' do
    before do
      bj_hand << card_class.new(3, 'A')
      bj_hand << card_class.new(9, 'B')
    end

    it 'returns true when value > 21' do
      bj_hand << card_class.new(12, 'A')

      expect(bj_hand.reveal.busted?).to eq(true)
    end

    it 'returns false when value <= 21' do
      bj_hand << card_class.new(9, 'A')

      expect(bj_hand.reveal.busted?).to eq(false)
    end
  end

  describe '#blackjack?' do
    it 'returns true when blackjack' do
      bj_hand << card_class.new(1, 'A')
      bj_hand << card_class.new(11, 'B')

      expect(bj_hand.reveal.blackjack?).to eq(true)
    end

    it 'returns true when blackjack' do
      bj_hand << card_class.new(5, 'A')
      bj_hand << card_class.new(6, 'A')
      bj_hand << card_class.new(11, 'B')

      expect(bj_hand.reveal.blackjack?).to eq(false)
    end
  end
end