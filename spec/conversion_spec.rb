require_relative 'spec_helper'

RSpec.describe Conversion do
  context '::new' do
    it 'exists' do
      conversion = Conversion.new

      expect(conversion).to be_instance_of(Conversion)
    end
  end

  context '#convert_key(key)' do
    it 'converts key into an integer array' do
      conversion = Conversion.new
      expected = [2, 27, 71, 15]

      expect(conversion.send(:convert_key, "02715")).to eq(expected)
    end
  end

  context '#convert_offset(date)' do
    it 'converts last four digits of date squared into an integer array' do
      conversion = Conversion.new
      expected = [1, 0, 2, 5]

      expect(conversion.send(:convert_offset, "040895")).to eq(expected)
    end
  end

  context '#join_keys_and_offsets(key, date)' do
    it 'converts keys and offsets into an nested array' do
      conversion = Conversion.new
      expected = [[2, 27, 71, 15], [1, 0, 2, 5]]

      expect(conversion.send(:join_keys_and_offsets, "02715", "040895")).to eq(expected)
    end
  end
end
