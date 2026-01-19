require 'direction'

RSpec.describe Direction do
    describe '.left' do
        it 'turns the left direction NORTH => WEST' do
            expect(Direction.left(:north)).to eq(:west)
        end

        it 'turns the left direction WEST => SOUTH' do
            expect(Direction.left(:west)).to eq(:south)
        end

        it 'turns the left direction SOUTH => EAST' do
            expect(Direction.left(:south)).to eq(:east)
        end
        
        it 'turns the left direction EAST => NORTH' do
            expect(Direction.left(:east)).to eq(:north)
        end

    end

    describe '.right' do
        it 'turns the right direction NORTH => EAST' do
            expect(Direction.right(:north)).to eq(:east)
        end

        it 'turns the right direction EAST => SOUTH' do
            expect(Direction.right(:east)).to eq(:south)
        end

        it 'turns the right direction SOUTH => WEST' do
            expect(Direction.right(:south)).to eq(:west)
        end

        it 'turns the right direction WEST => NORTH' do
            expect(Direction.right(:west)).to eq(:north)
        end
    end

    describe '.movement' do
        it 'returns the movement for a given direction NORTH' do
            expect(Direction.movement(:north)).to eq({ x: 0, y: 1 })
        end

        it 'returns the movement for a given direction EAST' do
            expect(Direction.movement(:east)).to eq({ x: 1, y: 0 })
        end

        it 'returns the movement for a given direction SOUTH' do
            expect(Direction.movement(:south)).to eq({ x: 0, y: -1 })
        end
        
        it 'returns the movement for a given direction WEST' do
            expect(Direction.movement(:west)).to eq({ x: -1, y: 0 })
        end
    end

    describe '.valid? with valid direction' do
        it 'returns true for a valid direction' do
            expect(Direction.valid?(:north)).to be true
        end

        it 'returns false for an invalid direction' do
            expect(Direction.valid?(:northwest)).to be false
        end
    end

    describe '.valid? with invalid direction' do
        it 'raises ArgumentError for .left' do
          expect { Direction.left(:invalid) }.to raise_error(ArgumentError)
        end
      
        it 'raises ArgumentError for .right' do
          expect { Direction.right(:invalid) }.to raise_error(ArgumentError)
        end
      
        it 'raises ArgumentError for .movement' do
          expect { Direction.movement(:invalid) }.to raise_error(ArgumentError)
        end
    end
end