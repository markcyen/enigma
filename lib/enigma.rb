require './spec/spec_helper'

class Enigma
  def generate_random_key
    5.times.map { rand(10) }.join
  end

  def validate?(date)
    convert_date = date.to_s
    if (convert_date.size == 6) && convert_date.to_i.instance_of?(Integer)
      !!(convert_date.match(/\d{2}\d{2}\d{2}/) && Date.strptime(convert_date, '%d%m%y'))
    else
      false
    end
  end

  def encrypt(message, key = generate_random_key, date = Date.today.strftime('%d%m%y'))
    if key.to_s.size == 5 && validate?(date)
      encrypt_message = EncryptionAlgorithm.new
      encrypted_hash = {
        encryption: encrypt_message.final_encryption(message, key, date),
        key: key,
        date: date
        }
    else
      "Invalid entry!"
    end
  end

  def decrypt(encrypted_message, key, date = Date.today.strftime('%d%m%y'))
    if key.to_s.size == 5 && validate?(date)
      decrypt_encryption = DecryptionAlgorithm.new
      decrypted_hash = {
        decryption: decrypt_encryption.final_decryption(encrypted_message, key, date),
        key: key,
        date: date
        }
    else
      decrypt_encryption = DecryptionAlgorithm.new
      decrypted_hash = {
        decryption: "You didn't provide something in proper order.\n" +
                    "Something smells fishy 🐟",
        key: key,
        date: date
        }
    end
  end
end
