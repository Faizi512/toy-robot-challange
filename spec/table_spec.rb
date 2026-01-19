require 'table'

RSpec.describe Table do
    let(:table) { Table.new }

    describe '#valid_position?' do
        context 'when the position is valid' do
            it 'returns true for origin (0, 0)' do
                expect(table.valid_position?(0, 0)).to be true
            end

            it 'returns true for center (2, 2)' do
                expect(table.valid_position?(2, 2)).to be true
            end

            it 'returns true for edge (4, 4)' do
                expect(table.valid_position?(4, 4)).to be true
            end
        end

        context 'when the position is invalid' do
            it 'returns false for Y out of bounds (0, 6)' do
                expect(table.valid_position?(0, 6)).to be false
            end

            it 'returns false for X out of bounds (6, 0)' do
                expect(table.valid_position?(6, 0)).to be false
            end

            it 'returns false for X negative (-1, 0)' do
                expect(table.valid_position?(-1, 0)).to be false
            end

            it 'returns false for Y negative (0, -1)' do
                expect(table.valid_position?(0, -1)).to be false
            end
        end
    end
end