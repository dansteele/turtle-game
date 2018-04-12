require 'turtle_game/commands/turtle'

RSpec.describe TurtleGame::Commands::Turtle do
  it "executes `turtle` command successfully" do
    output = StringIO.new
    moves = nil
    options = {}
    command = TurtleGame::Commands::Turtle.new(moves, options)

    command.execute(output: output)

    expect(output.string).to eq("OK\n")
  end
end
