require 'toy_robot'

RSpec.describe ToyRobot do
    let(:toy_robot) { ToyRobot.new }

    describe '#initialize' do
        it 'initializes the robot with nil values' do
            expect(toy_robot.x).to be_nil
            expect(toy_robot.y).to be_nil
            expect(toy_robot.direction).to be_nil
        end
    end 

    describe '#place' do
        context 'when the position is valid' do
            it 'places the robot on the table' do
                toy_robot.place(0, 0, :north)
                expect(toy_robot.x).to eq(0)
                expect(toy_robot.y).to eq(0)
                expect(toy_robot.direction).to eq(:north)
            end

            it 'can re-place the robot to a new position' do
                toy_robot.place(0, 0, :north)
                toy_robot.place(3, 3, :south)
                expect(toy_robot.x).to eq(3)
                expect(toy_robot.y).to eq(3)
                expect(toy_robot.direction).to eq(:south)
            end
        end
    end

    describe '#move' do
        context 'when the robot is placed' do
            it 'moves the robot one unit forward' do
                toy_robot.place(0, 0, :north)
                toy_robot.move
                expect(toy_robot.x).to eq(0)
                expect(toy_robot.y).to eq(1)
            end
        end

        context 'when the robot is not placed' do
            it 'ignores the move command' do
              toy_robot.move
              expect(toy_robot.x).to be_nil
              expect(toy_robot.y).to be_nil
              expect(toy_robot.direction).to be_nil
            end
        end
    end

    describe '#turn_left' do
        context 'when the robot is placed' do
            it 'turns the robot left' do
                toy_robot.place(0, 0, :north)
                toy_robot.turn_left
                expect(toy_robot.direction).to eq(:west)
            end
        end

        context 'when the robot is not placed' do
            it 'ignores the move command' do
                toy_robot.turn_left
                expect(toy_robot.direction).to be_nil
            end
        end
    end

    describe '#turn_right' do
        context 'when the robot is placed' do
            it 'turns the robot right' do
                toy_robot.place(0, 0, :north)
                toy_robot.turn_right
                expect(toy_robot.direction).to eq(:east)
            end
        end

        context 'when the robot is not placed' do
            it 'ignores the move command' do
                toy_robot.turn_right
                expect(toy_robot.direction).to be_nil
            end
        end
    end

    describe '#report' do
        context 'when the robot is placed' do
            it 'returns the robot\'s position and direction' do
                toy_robot.place(0, 0, :north)
                expect(toy_robot.report).to eq({ x: 0, y: 0, direction: :north })
            end
        end

        context 'when the robot is not placed' do
            it 'returns hash with nil values' do
              expect(toy_robot.report).to eq({ x: nil, y: nil, direction: nil })
            end
          end
    end

    describe '#placed?' do
        context 'when the robot is placed' do
            it 'returns true' do
                toy_robot.place(0, 0, :north)
                expect(toy_robot.placed?).to be true
            end
        end

        context 'when the robot is not placed' do
            it 'returns false' do
                expect(toy_robot.placed?).to be false
            end
        end
    end

    describe '#next_position' do
        context 'when the robot is placed' do
            it 'returns the robot\'s next position' do
            toy_robot.place(0, 0, :north)
            expect(toy_robot.next_position).to eq([0, 1])
            end
        end

        context 'when the robot is not placed' do
            it 'returns nil' do
            expect(toy_robot.next_position).to be_nil
            end
        end
    end

end