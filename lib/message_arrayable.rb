module MessageArrayable
  def characters_set
    ("a".."z").to_a << " "
  end

  def message_index_array(message)
    message_downcase_split = message.downcase.split("")
    message_index_array = []
    message_downcase_split.each do |chr|
      if !characters_set.include?(chr)
        message_index_array << chr
      else
        message_index_array << characters_set.index(chr)
      end
    end
    message_index_array
  end
end
