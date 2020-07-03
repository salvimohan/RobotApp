class Robot
  attr_accessor :current_position_x, :current_position_y, :current_direction, :board_length, :board_width
  MAX_BOARD_SIZE = 5
  DIRECTIONS = %w(NORTH EAST SOUTH WEST)

  def initialize(length = MAX_BOARD_SIZE, width = MAX_BOARD_SIZE)
    @board_length, @board_width = length, width
    @current_position_x, @current_position_y = nil, nil
    @current_position_direction = ''
  end

  def self.start(length = MAX_BOARD_SIZE, width = MAX_BOARD_SIZE)
    new(length, width).run
  end

  # return current position of Robot
  def current_place
    if @current_position_x.nil? && @current_position_y.nil? && @current_direction.nil?
      'not in place'
    else
      "#{@current_position_x}, #{@current_position_y}, #{@current_direction}"
    end
  end

  # execute command according user input 
  def execute_command(input)
    if input =~ /^PLACE\s+\d,\d,\s*(NORTH|EAST|SOUTH|WEST)/
      set_place_position(input)
    elsif input =~ /^MOVE$/
      move_forward if placed?
    elsif input =~ /^LEFT$/
      rotate_left if placed?
    elsif input =~ /^RIGHT$/
      rotate_right if placed?
    elsif input =~ /^REPORT$/
      report
    elsif input =~ /^EXIT$/
      puts 'End of the game'
    else
      puts "Invalid command"
    end
  end

  # this method is used to validate the board place
  def is_board_place?(x, y)
    x >= 0 && x < @board_length && y >= 0 && y < @board_width
  end

  # this method move the robot one place forward
  def move_forward
    x, y = @current_position_x, @current_position_y
    case @current_direction
    when 'NORTH'
      y = y + 1
    when 'EAST'
      x = x + 1
    when 'SOUTH'
      y = y - 1
    when 'WEST'
      x = x - 1
    end
   
    return unless is_board_place?(x, y)
   
    @current_position_x = x
    @current_position_y = y
  end

  # by this method, Robot rotates its position in left direction
  def rotate_left
    @current_direction = DIRECTIONS[DIRECTIONS.index(@current_direction) - 1]
  end

  # by this method, Robot rotates its position in right direction
  def rotate_right
    index = DIRECTIONS.index(@current_direction) + 1
    @current_direction = DIRECTIONS[(index == 4 ? 0 : index)]
  end

  # This method is useful to take user input
  def run
    puts '**********Welcome Robot Board**********'
    puts 'Play Description'
    puts 'Board Size is 5x5.'
    puts 'DIRECTION should be one of NORTH, EAST, SOUTH, WEST.'
    puts 'X and Y should be positive and not greater than lenth and width.'

    input = ''
    while (input.downcase != 'exit')
      puts '**************'
      puts 'Please enter the command one of the below or EXIT to quit'
      puts 'PLACE (Ex: PLACE X,Y,NORTH|EAST|SOUTH|WEST)'
      puts 'MOVE'
      puts 'LEFT'
      puts 'RIGHT'
      puts 'REPORT'
      puts '**************'
      print 'Enter '

      input = gets.chomp

      execute_command(input)
    end
  end

  def report
     puts current_place
  end

  # When user entered the place command
  # This method is place the position when input command is valid
  def set_place_position(input)
    input, x, y, direction = input.gsub(',', ' ').split(' ')
    x, y = x.to_i, y.to_i
    return unless is_board_place?(x, y)

    @current_position_x = x
    @current_position_y = y
    @current_direction = direction
  end

  def placed?
    !@current_direction.nil?
  end
end
