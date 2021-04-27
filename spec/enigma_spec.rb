require_relative 'spec_helper'

RSpec.describe Enigma do
  context '#initialize' do
    it 'exists' do
      enigma = Enigma.new

      expect(enigma).to be_instance_of(Enigma)
    end
  end

  context '#validate?(date)' do
    it 'checks if date is valid' do
      enigma = Enigma.new
      date_1 = "040895"

      expect(enigma.validate?(date_1)).to eq(true)

      date_2 = "04081995"
      expect(enigma.validate?(date_2)).to eq(false)

      date_3 = "Aug 4 1995"
      expect(enigma.validate?(date_3)).to eq(false)
    end
  end

  context '#encrypt' do
    it 'encrypts simple message with given key and date' do
      enigma = Enigma.new

      expected = {
        encryption: "keder ohulw",
        key: "02715",
        date: "040895"
      }
      expect(enigma.encrypt("hello world", "02715", "040895")).to eq(expected)
    end

    it 'encrypts simple message but with incorrect key' do
      enigma = Enigma.new

      expected = "Invalid entry!"
      expect(enigma.encrypt("hello world", "027157", "040895")).to eq(expected)
    end

    it 'encrypts simple message but with incorrect date' do
      enigma = Enigma.new

      expected = "Invalid entry!"
      expect(enigma.encrypt("hello world", "02715", "0408955")).to eq(expected)
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

    it 'decrypts a default message when entering incorrect key' do
      enigma = Enigma.new
      decrypted_message = enigma.decrypt("keder ohulw", "027157", "040895")

      expected = "You didn't provide something in proper order.\n" +
                 "Something smells fishy 🐟"

      expect(decrypted_message[:decryption]).to eq(expected)
    end

    it 'decrypts a default message when entering incorrect date' do
      enigma = Enigma.new
      decrypted_message = enigma.decrypt("keder ohulw", "027157", "0408957")

      expected = "You didn't provide something in proper order.\n" +
                 "Something smells fishy 🐟"

      expect(decrypted_message[:decryption]).to eq(expected)
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
        encryption: "qgfaxbqd ny",
        key: "02715",
        date: Date.today.strftime('%d%m%y')
      }
      expect(enigma.encrypt("hello world", "02715")).to eq(expected)
    end
  end

  context '#decrypt with todays date' do
    it 'decrypts message with default to todays date' do
      enigma = Enigma.new
      allow(Date).to receive(:today).and_return(Date.new(2021, 04, 24))
      encrypted = {
        encryption: "qgfaxbqd ny",
        key: "02715",
        date: Date.today.strftime('%d%m%y')
      }
      expected = {
        decryption: "hello world",
        key: "02715",
        date: Date.today.strftime('%d%m%y')
      }
      expect(enigma.decrypt(encrypted[:encryption], "02715")).to eq(expected)
    end
  end

  context '#generate_random_key' do
    it 'checks for generated five-digit random key' do
      enigma = Enigma.new

      expect(enigma.generate_random_key.size).to eq(5)
    end

    it 'encrypts message using five digit random number and todays date' do
      enigma = Enigma.new

      allow(enigma).to receive(:generate_random_key) { "02715" }
      allow(Date).to receive(:today).and_return(Date.new(2021, 04, 24))
      expected = {
        encryption: "qgfaxbqd ny",
        key: "02715",
        date: Date.today.strftime('%d%m%y')
      }

      expect(enigma.encrypt("hello world")).to eq(expected)
    end
  end
end
