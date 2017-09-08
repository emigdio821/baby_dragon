class Dragon
  def initialize(name)
    @array_options = %w[feed walk bed toss rock tips]
    @name = name
    @show_options = true
    @asleep = false
    @stuff_in_belly = 10
    @stuff_in_intestine = 0
    puts "Congratulations! #{@name} is born. Raawwwr!"
    options
  end

  def tips
    @show_options = true
    options
  end

  def options
    if @show_options
      puts "You can use the following commands to interact with < #{@name} >!"
      puts '-> Feed'
      puts '-> Walk'
      puts '-> Bed'
      puts '-> Toss'
      puts '-> Rock'
      @show_options = false
    else
      puts
      puts "You can insert \'tips\' word to show the options to interact with < #{@name} > :)"
    end
    puts

    cmd = gets.downcase.chomp
    puts
    interactions(cmd)
  end

  def interactions(cmd)
    if @array_options.include? cmd
      return feed if cmd == 'feed'
      return walk if cmd == 'walk'
      return put_to_bed if cmd == 'bed'
      return toss if cmd == 'toss'
      return rock if cmd == 'rock'
      return tips if cmd == 'tips'
    else
      puts 'Opps! That\'s and invalid command, try again.'
      options
    end
  end

  def feed
    puts "-- You feed #{@name}, nom nom --"
    @stuff_in_belly = 10
    passage_of_time
  end

  def walk
    puts "-- You walk #{@name} --"
    @stuff_in_intestine = 0
    passage_of_time
  end

  def put_to_bed
    puts "-- You put #{@name} to bed, zZZ... --"
    @asleep = true
    3.times do
      passage_of_time if @asleep
      puts "-- #{@name} snores, filling the room with smoke --" if @asleep
    end
    return unless @asleep
    @asleep = false
    puts "-- #{@name} wakes up slowly --"
  end

  def toss
    puts "-- You toss #{@name} up into the air --"
    puts '-- He giggles, which singes your eyebrows --'
    passage_of_time
  end

  def rock
    puts "-- You rock #{@name} gently --"
    @asleep = true
    puts '-- He briefly dozes off... --'
    passage_of_time
    return unless @asleep
    @asleep = false
    puts '-- ...but wakes when you stop --'
  end

  private

  # "private" means that the methods defined here are
  # methods internal to the object. (You can feed your # dragon,
  # but you can't ask him whether he's hungry.)
  def hungry?
    @stuff_in_belly <= 2
  end

  def dragon_wakes_up
    @asleep = false
    puts '-- He wakes up suddenly! --'
  end

  def poopy?
    @stuff_in_intestine >= 8
  end

  def passage_of_time
    if @stuff_in_belly > 0
      @stuff_in_belly -= 1
      @stuff_in_intestine += 1
    else
      # Our dragon is starving!
      dragon_wakes_up if @asleep
      puts "-- #{@name} is starving!  In desperation, he ate YOU! --"
      puts 'Game Over :('
      exit # This quits the program.
    end

    if @stuff_in_intestine >= 10
      @stuff_in_intestine = 0
      puts "-- Whoops! #{@name} had an accident... --"
    end

    if hungry?
      dragon_wakes_up if @asleep
      puts "#{@name}'s stomach grumbles... brrgrgr..."
    end

    if poopy?
      dragon_wakes_up if @asleep
      puts "#{@name} does the potty dance... yeah, time to shit >.<"
    end
    options
  end
end

def init_pet_program
  puts '<-- The Dragon Pet -->'
  puts
  print 'Choose a name for your Dragon: '
  dragon_name = gets.chomp.to_s
  if dragon_name != ''
    Dragon.new dragon_name
  else
    puts
    puts 'The name of your dragon cannot be empty.'
    puts
    init_pet_program
  end
end
init_pet_program
