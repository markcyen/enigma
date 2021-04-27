require_relative 'enigma'

handle = File.open(ARGV[0], "r")

encrypted_message = handle.read
enigma = Enigma.new

writer = File.open(ARGV[1], "w")

decrypt_message = enigma.decrypt(encrypted_message, ARGV[2].to_s, ARGV[3].to_s)
writer.write(decrypt_message[:decryption])

puts "Created '#{ARGV[1]}' with the key #{ARGV[2]} and date #{ARGV[3]}"

handle.close
writer.close
