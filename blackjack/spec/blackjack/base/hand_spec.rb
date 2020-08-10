RSpec.describe Blackjack::Base::Hand do
  subject(:hand) { described_class.new(name) }

  let(:name) { 'Dealer' }

  describe '#create' do
    it 'creates a named hand' do
      expect(hand.name).to eq(name)
    end

    it 'creates an empty hand' do
      expect(hand.cards).to eq([])
    end
  end

  describe '#value' do
    it 'expects from concrete class to implement value method' do
      expect { hand.value }.to raise_error(NotImplementedError)
    end

    context 'with concrete implementation' do
      let(:concrete_hand) do
        Class.new(described_class) do
          def value
            10
          end
        end.new('Test')
      end

      it 'does not raise error' do
        expect(concrete_hand.value).to eq(10)
      end
    end
  end

  describe '#<<' do
    it 'expects to append card to hand\'s cards' do
      expect { hand << 'card' }.to change(hand, :cards).to(['card'])
    end
  end
end