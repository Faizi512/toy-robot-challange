module Direction

    NORTH = :north
    SOUTH = :south
    EAST = :east
    WEST = :west

    CLOCKWISE = [NORTH, EAST, SOUTH, WEST].freeze


    MOVEMENTS = {
        NORTH => { x: 0, y: 1 },
        EAST => { x: 1, y: 0 },
        SOUTH => { x: 0, y: -1 },
        WEST => { x: -1, y: 0 }
    }.freeze

    def self.left(current_direction)
        validate!(current_direction)
        index = CLOCKWISE.index(current_direction)
        CLOCKWISE[(index - 1) % 4]
    end

    def self.right(current_direction)
        validate!(current_direction)
        index = CLOCKWISE.index(current_direction)
        CLOCKWISE[(index + 1) % 4]
    end

    def self.movement(current_direction)
        validate!(current_direction)
        MOVEMENTS[current_direction]
    end

    def self.valid?(direction)
        CLOCKWISE.include?(direction)
    end

    def self.validate!(direction)
        raise ArgumentError, "Invalid direction: #{direction}" unless valid?(direction)
    end
    private_class_method :validate!
end