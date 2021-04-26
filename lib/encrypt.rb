require_relative 'enigma'

handle = File.open(ARGV[0], "r")

incoming_message = handle.read
enigma = Enigma.new
encrypt_message = enigma.encrypt(incoming_message, "82648", "240818")

handle.close

writer = File.open(ARGV[1], "w")

writer.write(encrypt_message[:encryption])

writer.close
