require_relative 'direction'

module CommandParser

    VALID_COMMANDS = %w[MOVE LEFT RIGHT REPORT PLACE].freeze

    def self.parse(command)
        cmd, args = command.strip.upcase.split(' ', 2)
        return invalid_command unless VALID_COMMANDS.include?(cmd)

        case cmd
        when 'PLACE' then parse_place(args)
        else
            {command: cmd.downcase.to_sym}
        end
    end

    def self.parse_place(args)
        return invalid_command if args.nil?

        x, y, direction = args.split(',').map(&:strip)
        return invalid_command unless x && y && direction

        return invalid_command unless Direction.valid?(direction.downcase.to_sym)

        {command: :place, x: x.to_i, y: y.to_i, direction: direction.downcase.to_sym}
    end
    private_class_method :parse_place

    def self.invalid_command
        { command: :invalid, hint: "Valid commands: #{VALID_COMMANDS.join(', ')}" }
    end
    private_class_method :invalid_command
end