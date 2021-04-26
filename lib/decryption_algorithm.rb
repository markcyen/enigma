class DecryptionAlgorithm
  include MessageArrayable

  def final_decrypt_numbers(encrypted_message, key, date)
    conversion = Conversion.new
    convert_shift = conversion.calculate_shift(key, date)

    combined_decrypt = message_index_array(encrypted_message).zip(convert_shift.cycle)
    final_decrypt_numbers = combined_decrypt.map do |(num1, num2)|
      if num1.instance_of?(String)
        num1
      else
        num1 - num2
      end
    end
    final_decrypt_numbers
  end

  def final_decryption(encrypted_message, key, date)
    decrypted = final_decrypt_numbers(encrypted_message, key, date)
    decrypted.map do |shift|
      if shift.instance_of?(String)
        shift
      elsif shift <= -characters_set.size
        characters_set[shift % characters_set.size]
      else
        characters_set[shift]
      end
    end.join
  end
end
