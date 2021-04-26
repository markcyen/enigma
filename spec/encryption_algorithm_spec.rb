require_relative 'spec_helper'

RSpec.describe EncryptionAlgorithm do
  context '::new' do
    it 'exists' do
      encryption_algorithm = EncryptionAlgorithm.new

      expect(encryption_algorithm).to be_instance_of(EncryptionAlgorithm)
    end
  end

  context '#message_index_array(message)' do
    it 'converts message into coded array' do
      encryption_algorithm = EncryptionAlgorithm.new
      message = "hello world"

      expected = [7, 4, 11, 11, 14, 26, 22, 14, 17, 11, 3]
      expect(encryption_algorithm.message_index_array(message)).to eq(expected)
    end
  end

  context '#final_encrypt_numbers(message, key, date)' do
    it 'converts message into encrypted array' do
      encryption_algorithm = EncryptionAlgorithm.new
      message = "hello world"
      key = "02715"
      date = "040895"

      expected = [10, 31, 84, 31, 17, 53, 95, 34, 20, 38, 76]
      expect(encryption_algorithm.final_encrypt_numbers(message, key, date)).to eq(expected)
    end
  end

  context '#final_encryption(message, key, date)' do
    it 'encrypts message' do
      encryption_algorithm = EncryptionAlgorithm.new
      message = "hello world"
      key = "02715"
      date = "040895"

      expected = "keder ohulw"
      expect(encryption_algorithm.final_encryption(message, key, date)).to eq(expected)
    end
  end
end
