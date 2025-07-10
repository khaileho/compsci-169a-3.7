class WordGuesserGame
  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.

  # Get a word from remote "random word" service

  attr_accessor :word, :guesses, :wrong_guesses

  def initialize(word)
    @word = word
    @guesses = ""
    @wrong_guesses = ""
  end

  def guess(letter)
    letter = letter.to_s.downcase
    if letter !~ /^[a-z]$/
      raise ArgumentError
    end
    if @word.include?(letter)
      if !@guesses.include?(letter)
        @guesses += letter
        return true
      end
      return false
    else
      if !@wrong_guesses.include?(letter)
        @wrong_guesses += letter
        return true
      end
      return false
    end
  end

  def word_with_guesses
    display = ''
    @word.each_char do |letter|
      if @guesses.include?(letter)
        display += letter
      else
        display += '-'
      end
    end
    return display
  end

  def check_win_or_lose
    if word_with_guesses == @word
      return :win
    elsif @wrong_guesses.length >= 7
      return :lose
    else
      return :play
    end
  end

  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://randomword.saasbook.info/RandomWord')
    Net::HTTP.new('randomword.saasbook.info').start do |http|
      return http.post(uri, "").body
    end
  end
end
