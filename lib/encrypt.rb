require_relative 'enigma'

handle = File.open(ARGV[0], "r")

incoming_message = handle.read
enigma = Enigma.new
encrypt_message = enigma.encrypt(incoming_message, "82648", "240818")

handle.close

writer = File.open(ARGV[1], "w")

writer.write(encrypt_message[:encryption])

puts "Created '#{ARGV[1]}' with the key #{encrypt_message[:key].to_i} and date #{encrypt_message[:date].to_i}"

writer.close
