require 'date'

class Enigma

  # def initialize
  #   @encrypt = Hash.new { |hash, key| hash[key] = {} }
  #   @date = Date.today.strftime('%m%d%y')
  # end

  def characters_set
    chr_set = ("a".."z").to_a << " "
  end

  def encrypt(encryption,
    key = 5.times.map{rand(10)}.join,
    date = Date.today.strftime('%m%d%y')
  )
    downcase_encryption = encryption.downcase
    encryption_array = downcase_encryption.split("")
    convert_keys = key.chars

    join_keys = []
    convert_keys.each_cons(2) do |key|
      join_keys << key.join
    end

    join_keys_to_integer = join_keys.map do |key|
      key.to_i
    end

    offset = (date.to_i ** 2).to_s
    last_four_offset = offset.split("").last(4)
    last_four_to_integer = last_four_offset.map do |offset|
      offset.to_i
    end

    join_keys_and_offsets = []
    join_keys_and_offsets << join_keys_to_integer
    join_keys_and_offsets << last_four_to_integer
    join_keys_and_offsets

    calculate_shift = join_keys_and_offsets.transpose.map do |shift|
      shift.reduce(0) do |sum, integer|
        sum + integer
      end
    end

    encryption_index_array = []
    encryption_array.each do |chr|
      if !characters_set.include?(chr)
        encryption_index_array << chr
      else
        encryption_index_array << characters_set.index(chr)
      end
    end

    combined_encrypt = encryption_index_array.zip(calculate_shift.cycle)
    final_encrypt_numbers = combined_encrypt.map do |encrypt_numbers|
      if encrypt_numbers.any?{ |chr| chr.instance_of?(String) }
        encrypt_numbers.find{ |chr| chr.instance_of?(String) }
      else
        encrypt_numbers.reduce(0) do |sum, number|
          sum + number
        end
      end
    end

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
    # convert to hash as {
    # encryption: "keder ohulw",
    # key: "02715",
    # date: "040895"
    # }
  end

  def decrypt(decryption,
    key,
    date = Date.today.strftime('%m%d%y'))
    lowercase_decryption = decryption.downcase
    decryption_array = lowercase_decryption.split("")
    convert_keys = key.chars

    join_keys = []
    convert_keys.each_cons(2) do |key|
      join_keys << key.join
    end
    join_keys

    join_keys_to_integer = join_keys.map do |key|
      key.to_i
    end

    offset = (date.to_i ** 2).to_s
    last_four_offset = offset.split("").last(4)
    last_four_to_integer = last_four_offset.map do |offset|
      offset.to_i
    end

    join_keys_and_offsets = []
    join_keys_and_offsets << join_keys_to_integer
    join_keys_and_offsets << last_four_to_integer
    join_keys_and_offsets

    calculate_shift = join_keys_and_offsets.transpose.map do |shift|
      shift.reduce(0) do |sum, integer|
        sum + integer
      end
    end

    decryption_index_array = []
    decryption_array.each do |chr|
      if !characters_set.include?(chr)
        decryption_index_array << chr
      else
        decryption_index_array << characters_set.index(chr)
      end
    end

    combined_decrypt = decryption_index_array.zip(calculate_shift.cycle)
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
