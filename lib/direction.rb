module Direction
    class << self
        def left(current_direction)
            validate!(current_direction)
            index = CLOCKWISE.index(current_direction)
            CLOCKWISE[(index - 1) % 4]
        end

        def right(current_direction)
            validate!(current_direction)
            index = CLOCKWISE.index(current_direction)
            CLOCKWISE[(index + 1) % 4]
        end

        def movement(current_direction)
            validate!(current_direction)
            MOVEMENTS[current_direction]
        end

        def valid?(direction)
            CLOCKWISE.include?(direction)
        end

        private

        # Explicit order matters for rotation logic, not derived from MOVEMENTS.keys
        CLOCKWISE = [:north, :east, :south, :west].freeze

        MOVEMENTS = {
            north: { x: 0, y: 1 },
            east:  { x: 1, y: 0 },
            south: { x: 0, y: -1 },
            west:  { x: -1, y: 0 }
        }.freeze

        def validate!(direction)
            raise ArgumentError, "Invalid direction: #{direction}" unless valid?(direction)
        end
    end
end