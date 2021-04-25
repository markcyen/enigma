require 'date'

class Conversion

  def calculate_shift(key, date)
    complete_join = join_keys_and_offsets(key, date)
    complete_join.transpose.map do |shift|
      shift.reduce(0) do |sum, integer|
        sum + integer
      end
    end
  end

  private

  def convert_key(key)
    convert_keys = key.chars

    join_keys = []
    convert_keys.each_cons(2) do |key|
      join_keys << key.join
    end
    join_keys.map { |key| key.to_i }
  end

  def convert_offset(date)
    offset = (date.to_i ** 2).to_s
    last_four_offset = offset.split("").last(4)
    last_four_to_integer = last_four_offset.map do |offset|
      offset.to_i
    end
  end

  def join_keys_and_offsets(key, date)
    join_keys_and_offsets = []
    join_keys_and_offsets << convert_key(key)
    join_keys_and_offsets << convert_offset(date)
    join_keys_and_offsets
  end
end
