RSpec.describe Blackjack::Base::Card do
  subject(:card) { described_class.new(rank, suit) }

  let(:rank) { 12 }
  let(:suit) { 'A' }

  describe '#creation' do
    it 'creates a card with correct rank' do
      expect(card.rank).to eq(rank)
    end

    it 'creates a card with correct suit' do
      expect(card.suit).to eq(suit)
    end

    it 'creates a facedown card' do
      expect(card.revealed?).to eq(false)
    end

    context 'with illegal suit' do
      let(:suit) { 'F' }

      it 'raises an error' do
        expect { card }.to raise_error('Invalid suit')
      end
    end


    context 'with illegal suit' do
      let(:rank) { 0 }

      it 'raises an error' do
        expect { card }.to raise_error('Invalid rank')
      end
    end
  end

  describe '#reveal' do
    it 'reveals card' do
      expect { card.reveal }.to change(card, :revealed?).to(true)
    end
  end

  describe '#to_s' do
    it 'prints back of card when not revealed' do
      expect(card.to_s).to eq('🂠')
    end

    it 'prints card facing up when card is revealed' do
      card.reveal

      expect(card.to_s).to eq('🂭')
    end
  end
end