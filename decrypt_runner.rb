require "pry"

decryption = "keder!sprrdx"
key = "02715"
date = "040895"

lowercase_decryption = decryption.downcase

decryption_array = lowercase_decryption.split("")
# => ["k", "e", "d", "e", "r", " ", "o", "h", "u", "l", "w"]

characters_set = ("a".."z").to_a << " "
# => ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", " "]

convert_keys = key.chars
# => ["0", "2", "7", "1", "5"]
join_keys = []
convert_keys.each_cons(2) do |key|
  join_keys << key.join
end
join_keys
# => ["02", "27", "71", "15"]

join_keys_to_integer = join_keys.map do |key|
  key.to_i
end
# => [2, 27, 71, 15]

offset = (date.to_i ** 2).to_s
# => "1672401025"
last_four_offset = offset.split("").last(4)
# => ["1", "0", "2", "5"]
last_four_to_integer = last_four_offset.map do |offset|
  offset.to_i
end

join_keys_to_integer # => [2, 27, 71, 15]
last_four_to_integer # => [1, 0, 2, 5]

join_keys_and_offsets = []
join_keys_and_offsets << join_keys_to_integer
join_keys_and_offsets << last_four_to_integer
join_keys_and_offsets
# => [[2, 27, 71, 15], [1, 0, 2, 5]]

calculate_shift = join_keys_and_offsets.transpose.map do |shift|
  shift.reduce(0) do |sum, integer|
    sum + integer
  end
end
# => [3, 27, 73, 20]

decryption_index_array = []
decryption_array.each do |chr|
  if !characters_set.include?(chr)
    decryption_index_array << chr
  else
    decryption_index_array << characters_set.index(chr)
  end
end
# => [10, 4, 3, 4, 17, 26, 14, 7, 20, 11, 22]

combined_decrypt = decryption_index_array.zip(calculate_shift.cycle)
# => [[10, 3], [4, 27], [3, 73], [4, 20], [17, 3], [26, 27], [14, 73], [7, 20], [20, 3], [11, 27], [22, 73]]
# => [[10, 3], [4, 27], [3, 73], [4, 20], [17, 3], ["!", 27], [18, 73], [15, 20], [17, 3], [17, 27], [3, 73], [23, 20]]
final_decrypt_numbers = combined_decrypt.map do |(num1, num2)|
  if num1.instance_of?(String)
    num1
  else
    num1 - num2
  end
end
# => [7, -23, -70, -16, 14, -1, -59, -13, 17, -16, -51]

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
require "pry"; binding.pry
