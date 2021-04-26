class EncryptionAlgorithm
  include MessageArrayable

  def final_encrypt_numbers(message, key, date)
    # conversion = Conversion.new
    convert_shift = Conversion.calculate_shift(key, date)

    combined_encrypt = message_index_array(message).zip(convert_shift.cycle)
    final_encrypt_numbers = combined_encrypt.map do |encrypt_numbers|
      if encrypt_numbers.any?{ |chr| chr.instance_of?(String) }
        encrypt_numbers.find{ |chr| chr.instance_of?(String) }
      else
        encrypt_numbers.reduce(0) do |sum, number|
          sum + number
        end
      end
    end
    final_encrypt_numbers
  end

  def final_encryption(message, key, date)
    encrypted = final_encrypt_numbers(message, key, date)
    encrypted.map do |shift|
      if shift.instance_of?(String)
        shift
      elsif shift >= characters_set.size
        characters_set[shift % characters_set.size]
      else
        characters_set[shift]
      end
    end.join
  end
end
