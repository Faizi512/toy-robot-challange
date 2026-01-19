require 'command_parser'

RSpec.describe CommandParser do
  describe '.parse' do
    context 'with valid simple commands' do
      it 'parses MOVE command' do
        expect(CommandParser.parse('MOVE')).to eq({ command: :move })
      end

      it 'parses LEFT command' do
        expect(CommandParser.parse('LEFT')).to eq({ command: :left })
      end

      it 'parses RIGHT command' do
        expect(CommandParser.parse('RIGHT')).to eq({ command: :right })
      end

      it 'parses REPORT command' do
        expect(CommandParser.parse('REPORT')).to eq({ command: :report })
      end
    end

    context 'with valid PLACE command' do
        it 'parses PLACE command with coordinates and direction' do
          expect(CommandParser.parse('PLACE 1,2,NORTH')).to eq({ command: :place, x: 1, y: 2, direction: :north })
        end
      
        it 'parses PLACE command at origin facing EAST' do
          expect(CommandParser.parse('PLACE 0,0,EAST')).to eq({ command: :place, x: 0, y: 0, direction: :east })
        end
    end

    context 'with case insensitivity' do
        it 'parses lowercase move' do
          expect(CommandParser.parse('move')).to eq({ command: :move })
        end
      
        it 'parses mixed case Place' do
          expect(CommandParser.parse('Place 1,2,North')).to eq({ command: :place, x: 1, y: 2, direction: :north })
        end
    end

    context 'with whitespace' do
        it 'handles leading and trailing spaces' do
          expect(CommandParser.parse('  MOVE  ')).to eq({ command: :move })
        end
      
        it 'handles spaces around PLACE arguments' do
          expect(CommandParser.parse('PLACE 1, 2, NORTH')).to eq({ command: :place, x: 1, y: 2, direction: :north })
        end
    end

    context 'with invalid commands' do
        it 'returns invalid for unknown command' do
          result = CommandParser.parse('JUMP')
          expect(result[:command]).to eq(:invalid)
          expect(result[:hint]).to include('MOVE', 'LEFT', 'RIGHT', 'REPORT', 'PLACE')
        end
      
        it 'returns invalid for PLACE without arguments' do
          result = CommandParser.parse('PLACE')
          expect(result[:command]).to eq(:invalid)
        end
      
        it 'returns invalid for PLACE with invalid direction' do
          result = CommandParser.parse('PLACE 1,2,NORTHWEST')
          expect(result[:command]).to eq(:invalid)
        end
    end
  end
end