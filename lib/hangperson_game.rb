class HangpersonGame
    

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.
  # Get a word from remote "random word" service
  # def initialize()
  # end
  
   def initialize(word)
     @word = word
     @guesses = "" 
     @wrong_guesses = ""

   end
    
   def word 
       return @word 
   end
    
   def guesses 
       return @guesses 
   end
   
   def wrong_guesses
     return @wrong_guesses  
   end
    
    
   def guess(letter)
        if (letter == nil || letter == "" || letter.match?(/[^a-zA-Z]/))
            raise ArgumentError
        end
  # using POSIX character classes to check for capital letters
        if letter.match?(/[[:upper:]]/) 
            return false
        end
        if @word.include?(letter) && !@guesses.include?(letter)
            @guesses += letter
            return true
        elsif !@word.include?(letter) && !@wrong_guesses.include?(letter) 
             @wrong_guesses += letter
            return true
        else 
            return false
        end
    end

    
   def word_with_guesses
       partial_matches = ""
       
       @word.each_char do |w|
           if @guesses.include?(w)
              partial_matches += w 
           else
            partial_matches += "-"
           end
     end 
       return partial_matches
   end
    
    
    
    def check_win_or_lose
   
       if @wrong_guesses.length == 7
           :lose
  # for win: using self to call words_with_guesses to check if there aren't anymore "-"
       elsif !self.word_with_guesses.include?("-")
            :win 
       else   
            :play
       end
    end
    
   
  
  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
    
    
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

end
