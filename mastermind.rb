class Board

  attr_accessor :board, :secret, :guess

  def initialize()
    #draw board
    @board = [Array.new(4,"-")]
    @guess = []
    options = [1,2,3,4,5,6]
    @secret = Array.new(4) { options.sample }
  end

  def display_board()
    #only displaying the last/recent 4
    @board.last.join(" ")
  end

  def board_update()
    #append 4 items to the end
    @board << @guess
  end

  def feedback(input)
    feedback_arr = Array.new(4, "-")
    secret_used = Array.new(4, false)

    input.each_index do |i|
      if input[i] == secret[i]
        feedback_arr[i] = "🟢"
        secret_used[i] = true
      end
    end

    input.each_index do |i|
      next if feedback_arr[i] == "🟢"

      @secret.each_index do |j|
        if !secret_used[j] && input[i] == @secret[j]
          feedback_arr[i] = "🟡"
          secret_used[j] = true
          break
        end
      end
    end
    feedback_arr.join(" ")
  end
end

class Game
  def initialize()
    @board = Board.new
  end

  def start_game
    round = 0
    12.times do
      input = get_user_input()
      if valid_input?(input)
        @board.guess = input.split(',').map(&:to_i)
        @board.board_update
  
        feedback = @board.feedback(@board.guess)
        round += 1  # Increment the round only if the input is valid
        puts "Round #{round}: #{@board.display_board} | Feedback: #{feedback}"
        puts "-" * 40
  
        if @board.guess == @board.secret
          puts "Yay! You guessed the correct pattern in #{round} tries"
          break
        end
      else
        puts "Please enter in correct format"
      end
    end
  end  

  private

  def get_user_input()
    print "Enter 4 numbers from #1-6 to guess the correct pattern (ex: 1,2,3,4): "
    gets.chomp
  end

  def valid_input?(input)
    /^[1-6](?:,[1-6]){3}$/.match?(input)
  end
end

game = Game.new
game.start_game()