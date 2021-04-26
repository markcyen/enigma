require 'date'
require './spec/spec_helper'

class Enigma

  def generate_random_key
    5.times.map { rand(10) }.join
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

  def decrypt(encrypted_message,
    key,
    date = Date.today.strftime('%m%d%y')
  )

    decrypt_encryption = DecryptionAlgorithm.new

    decrypted_hash = {
      decryption: decrypt_encryption.final_decryption(encrypted_message, key, date),
      key: key,
      date: date
      }
  end

end
