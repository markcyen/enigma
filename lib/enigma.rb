require 'date'

class Enigma

  # def initialize
  #   @encrypt = Hash.new { |hash, key| hash[key] = {} }
  #   @date = Date.today.strftime('%m%d%y')
  # end

  def generate_random_key
    numbers_array = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
    five_digit_random = numbers_array.sample(5)
    five_digit_random.join
  end

  def characters_set
    chr_set = ("a".."z").to_a << " "
  end

  def encrypt(encryption,
    key = generate_random_key,
    date = Date.today.strftime('%m%d%y')
  )

    downcase_encryption = encryption.downcase
    encryption_array = downcase_encryption.split("")

    conversion = Conversion.new
    convert_shift = conversion.calculate_shift(key, date)

# Cipher class
    encryption_index_array = []
    encryption_array.each do |chr|
      if !characters_set.include?(chr)
        encryption_index_array << chr
      else
        encryption_index_array << characters_set.index(chr)
      end
    end

    combined_encrypt = encryption_index_array.zip(convert_shift.cycle)
    final_encrypt_numbers = combined_encrypt.map do |encrypt_numbers|
      if encrypt_numbers.any?{ |chr| chr.instance_of?(String) }
        encrypt_numbers.find{ |chr| chr.instance_of?(String) }
      else
        encrypt_numbers.reduce(0) do |sum, number|
          sum + number
        end
      end
    end

# enigma class
    encrypted = final_encrypt_numbers.map do |shift|
      if shift.instance_of?(String)
        shift
      elsif shift >= characters_set.size
        characters_set[shift % characters_set.size]
      else
        characters_set[shift]
      end
    end.join

    encrypted_hash = {
      encryption: encrypted,
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
