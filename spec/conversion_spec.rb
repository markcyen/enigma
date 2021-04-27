require_relative 'spec_helper'

RSpec.describe Conversion do
  context '::calculate_shift(key, date)' do
    it 'calculates shift to encrypt' do
      expected = [3, 27, 73, 20]
      expect(Conversion.calculate_shift("02715", "040895")).to eq(expected)
    end
  end

  context '::convert_key(key)' do
    it 'converts key into an integer array' do
      expected = [2, 27, 71, 15]

      expect(Conversion.send(:convert_key, "02715")).to eq(expected)
    end
  end

  context '::convert_offset(date)' do
    it 'converts last four digits of date squared into an integer array' do
      expected = [1, 0, 2, 5]

      expect(Conversion.send(:convert_offset, "040895")).to eq(expected)
    end
  end

  context '::join_keys_and_offsets(key, date)' do
    it 'converts keys and offsets into an nested array' do
      expected = [[2, 27, 71, 15], [1, 0, 2, 5]]

      expect(Conversion.send(:join_keys_and_offsets, "02715", "040895")).to eq(expected)
    end
  end
end
