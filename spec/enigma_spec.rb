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

    it 'encrypts simple message with special character' do
      enigma = Enigma.new

      expected = {
        encryption: "keder!sprrdx",
        key: "02715",
        date: "040895"
      }
      expect(enigma.encrypt("hello! world", "02715", "040895")).to eq(expected)
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

    it 'decrypts simple message with special character' do
      enigma = Enigma.new

      expected = {
        decryption: "hello! world",
        key: "02715",
        date: "040895"
      }
      expect(enigma.decrypt("keder!sprrdx", "02715", "040895")).to eq(expected)
    end
  end

  context '#encrypt with todays date' do
    it 'encrypts message with default to todays date' do
      enigma = Enigma.new
      allow(Date).to receive(:today).and_return(Date.new(2021, 04, 24))
      expected = {
        encryption: "kgfarbqduny",
        key: "02715",
        date: Date.today.strftime('%m%d%y')
      }
      expect(enigma.encrypt("hello world", "02715")).to eq(expected)
    end
  end

  context '#decrypt with todays date' do
    it 'decrypts message with default to todays date' do
      enigma = Enigma.new
      allow(Date).to receive(:today).and_return(Date.new(2021, 04, 24))
      expected = {
        decryption: "hello world",
        key: "02715",
        date: Date.today.strftime('%m%d%y')
      }
      expect(enigma.decrypt("kgfarbqduny", "02715")).to eq(expected)
    end
  end

  context '#encrypt with random five digit number' do
    it 'encrypts message using five digit random number and todays date' do
      enigma = Enigma.new
      conversion = Conversion.new

      allow(enigma).to receive(:generate_random_key) { "02715" }
      allow(Date).to receive(:today).and_return(Date.new(2021, 04, 24))
      expected = {
        encryption: "kgfarbqduny",
        key: "02715",
        date: Date.today.strftime('%m%d%y')
      }

      expect(enigma.encrypt("hello world")).to eq(expected)
    end
  end
end
