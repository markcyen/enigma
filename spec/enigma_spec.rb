require_relative 'spec_helper'

RSpec.describe Enigma do
  context '#initialize' do
    it 'exists' do
      enigma = Enigma.new

      expect(enigma).to be_instance_of(Enigma)
    end
  end
end
