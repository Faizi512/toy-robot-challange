require_relative 'table'
require_relative 'toy_robot'
require_relative 'command_parser'

class Simulator
  def initialize
    @table = Table.new
    @robot = ToyRobot.new
  end

  def execute(line)
    command = CommandParser.parse(line)
    case command[:command]
    when :place  then execute_place(**command.slice(:x, :y, :direction))
    when :move   then execute_move
    when :left   then execute_left
    when :right  then execute_right
    when :report then execute_report
    when :noop   then { success: true, command: :noop }
    else
      { success: false, command: command[:command], reason: "Invalid command (Hint: #{command[:hint]})" }
    end
  end

  private

  def execute_place(x:, y:, direction:)
    return { success: false, command: :place, reason: 'Invalid position' } unless @table.valid_position?(x, y)
  
    @robot.place(x, y, direction)
    { success: true, command: :place }
  end

  def execute_move
    return { success: false, command: :move, reason: 'Robot not placed' } unless @robot.placed?
  
    next_x, next_y = @robot.next_position
    return { success: false, command: :move, reason: 'Would fall off table' } unless @table.valid_position?(next_x, next_y)
  
    @robot.move
    { success: true, command: :move }
  end

  def execute_left
    return { success: false, command: :left, reason: 'Robot not placed' } unless @robot.placed?
  
    @robot.turn_left
    { success: true, command: :left }
  end

  def execute_right
    return { success: false, command: :right, reason: 'Robot not placed' } unless @robot.placed?
  
    @robot.turn_right
    { success: true, command: :right }
  end

  def execute_report
    return { success: false, command: :report, reason: 'Robot not placed' } unless @robot.placed?
  
    report = @robot.report
    output = "#{report[:x]},#{report[:y]},#{report[:direction].to_s.upcase}"
    { success: true, command: :report, output: output }
  end
end