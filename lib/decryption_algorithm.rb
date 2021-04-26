class DecryptionAlgorithm

  def characters_set
    ("a".."z").to_a << " "
  end

  def message_index_array(encrypted_message)
    downcase_encrypted_message = encrypted_message.downcase
    decrypted_message_array = downcase_encrypted_message.split("")
    decrypted_message_index_array = []
    decrypted_message_array.each do |chr|
      if !characters_set.include?(chr)
        decrypted_message_index_array << chr
      else
        decrypted_message_index_array << characters_set.index(chr)
      end
    end
    decrypted_message_index_array
  end

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
