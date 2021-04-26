require_relative 'enigma'

handle = File.open(ARGV[0], "r")

incoming_message = handle.read
enigma = Enigma.new
decrypt_message = enigma.decrypt(incoming_message)

handle.close

writer = File.open(ARGV[1], "w")

writer.write(encrypt_message)

writer.close
