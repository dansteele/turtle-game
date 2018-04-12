module TurtleGame
  class Game

    MOVESET = { 'w' => :up, 'a' => :left, 's' => :down, 'd' => :right }.freeze
    INDEX_MODIFIERS = { up: [-1, 0], left: [0, -1], down: [1, 0], right: [0, 1] }

    attr_accessor :move_history, :current_move, :matrix, :output

    def initialize(width = nil, output)
      @width = width
      @output = output
      @move_history = []
      @matrix = fetch_dimensions
    end

    def move(direction)
      move_history << parse_direction(direction)
      flush
      build_matrix
      output.puts stringify_matrix
    end

    private

    def stringify_matrix
      output = []
      matrix.each_with_index do |y_axis, index|
        matrix[index].each { |x_value| output << x_value }
        output << "\n"
      end
      output.join
    end

    def parse_direction(input)
      MOVESET[input.strip.downcase]
    end

    def flush
      $stdout.flush
    end

    def build_matrix
      last_move = [0, 0]
      move_history.each_with_index do |move, i|
        index_modifiers = INDEX_MODIFIERS[move]
        last_move = last_move.zip(index_modifiers).map(&:sum)
        matrix[last_move[0]][last_move[1]] = last_move?(i) ? '🐢' : '#'
      end
    end

    def last_move?(i)
      move_history.length == i + 1
    end

    def fetch_screen_size
      dimensions = TTY::Screen.size
      Array.new(dimensions[0]) { ' ' }.map { Array.new(dimensions[1]) { ' ' } }
    end

    def fetch_dimensions
      if @width
        Array.new(width) { ' ' }.map { Array.new(width) { ' ' } }
      else
        fetch_screen_size
      end
    end
  end
end
