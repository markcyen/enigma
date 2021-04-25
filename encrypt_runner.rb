require "pry"

encryption = "hello world"
key = "02715"
date = "040895"

lowercase_encryption = encryption.downcase

encryption_array = lowercase_encryption.split("")
# => ["h", "e", "l", "l", "o", " ", "w", "o", "r", "l", "d"]

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

# key_a = (convert_keys[0] + convert_keys[1])
# # => 2
# # key_a = (convert_keys[0] + convert_keys[1]) # => "02"
# # key_a_integer = key_a.to_i
# key_b = (convert_keys[1] + convert_keys[2])
# # => 27
# # key_b = (convert_keys[1] + convert_keys[2]) # => "27"
# # key_b_integer = key_b.to_i
# key_c = (convert_keys[2] + convert_keys[3])
# # => 71
# # key_c = (convert_keys[2] + convert_keys[3]) # => "71"
# # key_c_integer = key_c.to_i
# key_d = (convert_keys[3] + convert_keys[4])
# # => 15
# # key_d = (convert_keys[3] + convert_keys[4])# => "15"
# # key_d_integer = key_d.to_i

offset = (date.to_i ** 2).to_s
# => "1672401025"
last_four_offset = offset.split("").last(4)
# => ["1", "0", "2", "5"]
last_four_to_integer = last_four_offset.map do |offset|
  offset.to_i
end
# => [1, 0, 2, 5]

# offset_a = last_four_to_integer[0]
# # => 1
# offset_b = last_four_to_integer[1]
# # => 0
# offset_c = last_four_to_integer[2]
# # => 2
# offset_d = last_four_to_integer[3]
# # => 5

# encrypt_a = key_a + offset_a
# # => 3
# encrypt_b = key_b + offset_b
# # = 27
# encrypt_c = key_c + offset_c
# # => 73
# encrypt_d = key_d + offset_d
# # => 20

# characters_set.index(encryption_array[0])
# => 7
# encryption_array[0] is "h"
# so characters_set.index("h") is 7

# first_chr = characters_set.index(encryption_array[0]) + encrypt_a
# # => 10
#
# code_1 = characters_set[first_chr]
# # => "k"

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

encryption_index_array = []
encryption_array.each do |chr|
  encryption_index_array << characters_set.index(chr)
end
# => [7, 4, 11, 11, 14, 26, 22, 14, 17, 11, 3]

combined_encrypt = encryption_index_array.zip(calculate_shift.cycle)
# => [[7, 3], [4, 27], [11, 73], [11, 20], [14, 3], [26, 27], [22, 73], [14, 20], [17, 3], [11, 27], [3, 73]]
final_encrypt_numbers = combined_encrypt.map do |encrypt_numbers|
  encrypt_numbers.reduce(0) do |sum, number|
    sum + number
  end
end
# => [10, 31, 84, 31, 17, 53, 95, 34, 20, 38, 76]


# characters_set => ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", " "]

# encrypted = []
encrypted = final_encrypt_numbers.map do |shift|
  if shift > characters_set.size
    # encrypted <<
    characters_set[shift % 27]
  else
    # encrypted <<
    characters_set[shift]
  end
end.join

# encryption_index_and_calc_shift = []
# encryption_index_and_calc_shift << encryption_index_array
# encryption_index_and_calc_shift << calculate_shift
# encryption_index_and_calc_shift
# # => [[7, 4, 11, 11, 14, 26, 22, 14, 17, 11, 3], [3, 27, 73, 20]]


require "pry"; binding.pry

# find_chr = characters_set.find do |character|
#   character.include?(encryption_array[0])
# end
# # find_chr => "h"
