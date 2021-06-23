class Hangman
  DICTIONARY = ["cat", "dog", "bootcamp", "pizza"]

  def self.random_word 
     DICTIONARY.sample
  end

  def initialize
    @secret_word = Hangman.random_word
    @guess_word = Array.new(@secret_word.length, "_")
    @attempted_chars = []
    @remaining_incorrect_guesses = 5
  end

  def guess_word
    @guess_word
  end

  def attempted_chars
    @attempted_chars
  end

  def remaining_incorrect_guesses
    @remaining_incorrect_guesses
  end

  def already_attempted?(char)
    if @attempted_chars.include?(char)
      return true
    else
      return false
    end
  end

  def get_matching_indices(char1)
    arr = []
    @secret_word.each_char.with_index do |char2, i|
      arr << i if char1 == char2
    end
    arr
  end

  def fill_indices(char, arr)
    @guess_word.each_with_index do |ele, i|
      @guess_word[i] = char if arr.include?(i)
    end
  end

  def try_guess(char)
    attempt = already_attempted?(char)
    index_arr = get_matching_indices(char)
    @remaining_incorrect_guesses -= 1 if index_arr.length == 0
    fill_indices(char, index_arr)
    if attempt == true
      puts "that has already been attempted"
      return false
    elsif attempt == false
      @attempted_chars << char
      return true
    end
  end

  def ask_user_for_guess
    puts "Enter a char: "
    char = gets.chomp
    try_guess(char)
  end

  def win?
    if @guess_word.join == @secret_word
      puts "WIN"
      return true
    else
      return false
    end
  end

  def lose?
    if @remaining_incorrect_guesses == 0
      puts "LOSE"
      return true 
    else
      return false
    end
  end

  def game_over?
    if self.lose? == true || self.win? == true
      puts @secret_word
      return true 
    end
    false
  end

end
