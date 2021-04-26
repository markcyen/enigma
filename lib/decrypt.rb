require_relative 'enigma'

handle = File.open(ARGV[0], "r")

key = ARGV[2].to_s
date = ARGV[3].to_s

encrypted_message = handle.read
enigma = Enigma.new
decrypt_message = enigma.decrypt(encrypted_message, key, date)

handle.close

writer = File.open(ARGV[1], "w")

writer.write(decrypt_message[:decryption])

writer.close
