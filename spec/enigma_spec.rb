require_relative 'spec_helper'

RSpec.describe Enigma do
  context '#initialize' do
    it 'exists' do
      enigma = Enigma.new

      expect(enigma).to be_instance_of(Enigma)
    end
  end

  context '#encrypt' do
    it 'encrypts simple message' do
      enigma = Enigma.new

      expected = {
        encryption: "keder ohulw",
        key: "02715",
        date: "040895"
      }
      expect(enigma.encrypt("hello world", "02715", "040895")).to eq(expected)
    end
  end
end
