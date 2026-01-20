require_relative 'direction'

module CommandParser

    class << self

        def parse(command)
            cmd_string = command.strip
            return { command: :noop } if cmd_string.empty?
            
            cmd, args = cmd_string.upcase.split(' ', 2)
            return invalid_command unless VALID_COMMANDS.include?(cmd)

            case cmd
            when 'PLACE' then parse_place(args)
            else
                {command: cmd.downcase.to_sym}
            end
        end

        private

        VALID_COMMANDS = %w[MOVE LEFT RIGHT REPORT PLACE].freeze

        def parse_place(args)
            return { command: :invalid, hint: "PLACE requires arguments: X,Y,DIRECTION" } if args.nil?
        
            x, y, direction = args.split(',').map(&:strip)
            return { command: :invalid, hint: "PLACE requires format: X,Y,DIRECTION" } unless x && y && direction
        
            direction_sym = direction.downcase.to_sym
            return { command: :invalid, hint: "Invalid direction. Use: NORTH, SOUTH, EAST, WEST" } unless Direction.valid?(direction_sym)
        
            {command: :place, x: x.to_i, y: y.to_i, direction: direction_sym}
        end

        def invalid_command
            { command: :invalid, hint: "Valid commands: #{VALID_COMMANDS.join(', ')}" }
        end
    end
end