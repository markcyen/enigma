require_relative 'spec_helper'

RSpec.describe DecryptionAlgorithm do
  context '::new' do
    it 'exists' do
      decryption_algorithm = DecryptionAlgorithm.new

      expect(decryption_algorithm).to be_instance_of(DecryptionAlgorithm)
    end
  end

  context '#message_index_array(encrypted_message)' do
    it 'converts message into coded array' do
      decryption_algorithm = DecryptionAlgorithm.new
      encrypted_message = "keder ohulw"

      expected = [10, 4, 3, 4, 17, 26, 14, 7, 20, 11, 22]
      expect(decryption_algorithm.message_index_array(encrypted_message)).to eq(expected)
    end
  end

  context '#final_decrypt_numbers(encrypted_message, key, date)' do
    it 'converts message into decrypted array' do
      decryption_algorithm = DecryptionAlgorithm.new
      encrypted_message = "keder ohulw"
      key = "02715"
      date = "040895"

      expected = [7, -23, -70, -16, 14, -1, -59, -13, 17, -16, -51]
      expect(decryption_algorithm.final_decrypt_numbers(encrypted_message, key, date)).to eq(expected)
    end
  end

  context '#final_decryption(encrypted_message, key, date)' do
    it 'decrypts message' do
      decryption_algorithm = DecryptionAlgorithm.new
      encrypted_message = "keder ohulw"
      key = "02715"
      date = "040895"

      expected = "hello world"
      expect(decryption_algorithm.final_decryption(encrypted_message, key, date)).to eq(expected)
    end
  end
end
