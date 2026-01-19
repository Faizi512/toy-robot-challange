require_relative 'direction'

class ToyRobot
    attr_reader :x, :y, :direction

    def initialize
        @x = nil
        @y = nil
        @direction = nil
    end

    def place(x, y, direction)
        @x = x
        @y = y
        @direction = direction
    end

    def move
        return unless placed?

        x_axis, y_axis = Direction.movement(@direction).values
        @x += x_axis
        @y += y_axis
    end

    def turn_left
        return unless placed?

        @direction = Direction.left(@direction)
    end

    def turn_right
        return unless placed?

        @direction = Direction.right(@direction)
    end

    def next_position
        return nil unless placed?

        x_axis, y_axis = Direction.movement(@direction).values
        [@x + x_axis, @y + y_axis]
    end

    def report
        { x: @x, y: @y, direction: @direction }
    end

    def placed?
        !@x.nil? && !@y.nil? && !@direction.nil?
    end
end