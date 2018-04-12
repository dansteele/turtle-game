# frozen_string_literal: true

require 'thor'

module TurtleGame
  # Handle the application command line parsing
  # and the dispatch to various command objects
  #
  # @api public
  class CLI < Thor
    # Error raised by this runner
    Error = Class.new(StandardError)

    desc 'version', 'turtle_game version'
    def version
      require_relative 'version'
      puts "v#{TurtleGame::VERSION}"
    end
    map %w(--version -v) => :version

    desc 'turtle [WIDTH]', 'Start the game with an optional board width modifier'
    method_option :help, aliases: '-h', type: :boolean,
                         desc: 'Display usage information'
    def turtle(width = nil)
      if options[:help]
        invoke :help, ['turtle']
      else
        require_relative 'commands/turtle'
        TurtleGame::Commands::Turtle.new(width, options).execute
      end
    end
  end
end
