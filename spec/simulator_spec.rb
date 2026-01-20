require 'simulator'

RSpec.describe Simulator do
  let(:simulator) { Simulator.new }

  describe '#execute' do
    context 'with PLACE command' do
      it 'places robot at valid position' do
        result = simulator.execute("PLACE 0,0,NORTH")
        expect(result[:success]).to be true
        expect(result[:command]).to eq(:place)
    
        # Verify robot is actually placed
        report = simulator.execute("REPORT")
        expect(report[:output]).to eq('0,0,NORTH')
    end

      it 'fails for invalid position' do
        result = simulator.execute("PLACE 5,5,NORTH")
        expect(result[:success]).to be false
      end
    end

    context 'with MOVE command' do
        it 'moves robot when placed' do
          simulator.execute("PLACE 0,0,NORTH")
          result = simulator.execute("MOVE")
          expect(result[:success]).to be true

          # Verify robot actually moved
          report = simulator.execute("REPORT")
          expect(report[:output]).to eq('0,1,NORTH')
        end
      
        it 'fails when move would fall off table' do
          simulator.execute("PLACE 0,0,SOUTH")
          result = simulator.execute("MOVE")
          expect(result[:success]).to be false
        end
      
        it 'fails when robot not placed' do
          result = simulator.execute("MOVE")
          expect(result[:success]).to be false
        end
    end

    context 'with LEFT command' do
        it 'turns robot left when placed' do
          simulator.execute("PLACE 0,0,NORTH")
          result = simulator.execute("LEFT")
          expect(result[:success]).to be true

          # Verify robot actually turned left
          report = simulator.execute("REPORT")
          expect(report[:output]).to eq('0,0,WEST')
        end
      
        it 'fails when robot not placed' do
          result = simulator.execute("LEFT")
          expect(result[:success]).to be false
        end
      end
      
      context 'with RIGHT command' do
        it 'turns robot right when placed' do
          simulator.execute("PLACE 0,0,NORTH")
          result = simulator.execute("RIGHT")
          expect(result[:success]).to be true

          # Verify robot actually turned right
          report = simulator.execute("REPORT")
          expect(report[:output]).to eq('0,0,EAST')
        end
      
        it 'fails when robot not placed' do
          result = simulator.execute("RIGHT")
          expect(result[:success]).to be false
        end
    end

    context 'with REPORT command' do
        it 'returns position when placed' do
          simulator.execute("PLACE 1,2,EAST")
          result = simulator.execute("REPORT")
          expect(result[:success]).to be true
          expect(result[:output]).to eq('1,2,EAST')
        end
      
        it 'fails when robot not placed' do
          result = simulator.execute("REPORT")
          expect(result[:success]).to be false
        end
    end

    context 'with INVALID command' do
        it 'returns failure for invalid command' do
          result = simulator.execute("INVALID")
          expect(result[:success]).to be false
        end
    end
  end
end