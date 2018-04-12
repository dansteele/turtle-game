RSpec.describe "`turtle_game turtle` command", type: :cli do
  it "executes `turtle --help` command successfully" do
    output = `turtle_game turtle --help`
    expect(output).to match <<-OUT
Usage:
  turtle_game turtle MOVES

Options:
  -h, [--help], [--no-help]  # Display usage information

Command description...
    OUT
  end
end
