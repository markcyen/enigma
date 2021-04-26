require_relative 'enigma'

handle = File.open(ARGV[0], "r")

incoming_message = handle.read
enigma = Enigma.new
encrypt_message = enigma.encrypt(incoming_message, "82648", "240818")

puts encrypt_message[:encryption]
puts encrypt_message[:key]
puts encrypt_message[:date]

handle.close

writer = File.open(ARGV[1], "w")

writer.write(encrypt_message[:encryption])
writer.write("---------")
writer.write(encrypt_message[:key])
writer.write("---------")
writer.write(encrypt_message[:date])

writer.close
