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

  context '#decrypt' do
    it 'decrypts simple message' do
      enigma = Enigma.new

      expected = {
        decryption: "hello world",
        key: "02715",
        date: "040895"
      }
      expect(enigma.decrypt("keder ohulw", "02715", "040895")).to eq(expected)
    end
  end

  context '#encrypt' do
    it 'encrypts message with default to todays date' do
      enigma = Enigma.new

      expected = {
        encryption: "kgfarbqduny",
        key: "02715",
        date: Date.today.strftime('%m%d%y')
      }
      expect(enigma.encrypt("hello world", "02715")).to eq(expected)
    end
  end

  context '#decrypt' do
    it 'decrypts message with default to todays date' do
      enigma = Enigma.new

      expected = {
        decryption: "hello world",
        key: "02715",
        date: Date.today.strftime('%m%d%y')
      }
      expect(enigma.decrypt("kgfarbqduny", "02715")).to eq(expected)
    end
  end
end
