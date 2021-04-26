require_relative 'spec_helper'

RSpec.describe MessageArrayable do
  context '#characters_set' do
    it 'has an array of lowercase characters including a space' do
      encryption_algorithm = EncryptionAlgorithm.new
      expected = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", " "]

      expect(encryption_algorithm.characters_set).to eq(expected)
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
end
