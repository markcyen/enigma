require 'date'

class Enigma

  def generate_random_key
    numbers_array = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
    five_digit_random = numbers_array.sample(5)
    five_digit_random.join
  end

  def characters_set
    ("a".."z").to_a << " "
  end

  def encrypt(message,
    key = generate_random_key,
    date = Date.today.strftime('%m%d%y')
  )

    encrypt_message = EncryptionAlgorithm.new

    encrypted_hash = {
      encryption: encrypt_message.final_encryption(message, key, date),
      key: key,
      date: date
      }
  end

  def decrypt(decryption,
    key,
    date = Date.today.strftime('%m%d%y')
  )

    lowercase_decryption = decryption.downcase
    decryption_array = lowercase_decryption.split("")

    conversion = Conversion.new
    convert_shift = conversion.calculate_shift(key, date)

    decryption_index_array = []
    decryption_array.each do |chr|
      if !characters_set.include?(chr)
        decryption_index_array << chr
      else
        decryption_index_array << characters_set.index(chr)
      end
    end

    combined_decrypt = decryption_index_array.zip(convert_shift.cycle)
    final_decrypt_numbers = combined_decrypt.map do |(num1, num2)|
      if num1.instance_of?(String)
        num1
      else
        num1 - num2
      end
    end

    decrypted = final_decrypt_numbers.map do |shift|
      if shift.instance_of?(String)
        shift
      elsif shift <= -characters_set.size
        # encrypted <<
        characters_set[shift % characters_set.size]
      else
        # encrypted <<
        characters_set[shift]
      end
    end.join

    decrypted_hash = {
      decryption: decrypted,
      key: key,
      date: date
      }
  end

end
