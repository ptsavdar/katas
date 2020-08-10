module Blackjack
  class Game
    def initialize
      reset
    end

    def reset
      @deck = ::Blackjack::Base::Deck.new
    end

    def play
      initialize_hands
      deal_first_cards
      loop_player
      loop_dealer unless player.busted?
      print_final_score
    rescue RuntimeError
      puts 'Deck is now empty, you should reset before playing...'
    end

    private

    attr_reader :deck, :dealer, :player

    def initialize_hands
      # For simplicity we assume there's only a Dealer & a Player
      @dealer = ::Blackjack::BlackjackHand.new('Dealer')
      @player = ::Blackjack::BlackjackHand.new('Player')
    end

    def deal_first_cards
      deal_card(dealer)
      deal_revealed_card(player)
      deal_revealed_card(player)
    end

    def loop_player
      while player.active?
        print_hands
        puts 'Hit or Stand?'
        case gets.chomp.downcase
        when 'hit'
          deal_revealed_card(player)
        else
          player.stand
        end
        puts "\n"
      end
    end
    
    def loop_dealer
      dealer.reveal
      while dealer.active?
        deal_revealed_card(dealer)
        dealer.stand if dealer.value >= 17
      end
    end

    def print_hands
      puts @dealer.to_s
      puts @player.to_s
    end

    def print_final_score
      print_hands
      puts '============================================='
      if player.busted?
        puts 'You got busted. Dealer wins...'
      elsif dealer.busted?
        puts 'Dealer got busted. You win!'
      else
        puts ['Dealer Wins', 'It\'s a tie', 'You win'][(player.value <=> dealer.value) + 1]
      end
      puts "=============================================\n\n"
    end

    def deal_revealed_card(hand)
      hand << deck.next_revealed
    end

    def deal_card(hand)
      hand << deck.next
    end
  end
end