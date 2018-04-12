# frozen_string_literal: true

require_relative '../command'
require_relative '../game'
require 'tty-reader'
require 'pry'
module TurtleGame
  module Commands
    class Turtle < TurtleGame::Command
      attr_accessor :move_input

      def initialize(width, options)
        @width = width
        @options = options
      end

      def execute(input: $stdin, output: $stdout)
        put_instructions(output)
        game = TurtleGame::Game.new(@width, output)
        loop do
          move_input = TTY::Reader.new.read_char
          break if move_input == 'x'
          game.move(move_input)
        end
        output.puts 'Thanks for playing'
      end

      private

      def put_instructions(output)
        output.puts <<~INSTRUCTIONS

        Use WASD to move your tutle
        Use X to exit

        INSTRUCTIONS
      end
    end
  end
end
