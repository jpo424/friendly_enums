module Enum

  # given list of arrays of teh form[:symbol,number,'description'],
  # use the symbol as the constant, the number as the value and
  # the description as human readbale descrption of constant 
  def define_enum(*entries)
    @hash = {}
    entries.each do |info|
      if info.size == 3 && info[0].is_a?(Symbol) && info[1].is_a?(Fixnum)
       @hash[info[0]] = [info[1], info[2].to_s] 
      else
        raise ArgumentError.new("Invalid enum: #{info.inspect}") 
      end 
    end
    @hash.each {|k,v| const_set(k.to_s.upcase, v[0])}
  end

  # List of all keys
  def keys
    @hash.keys
  end

  # given ID, returns the key
  def to_key(id)
    key = nil
    @hash.each do |k,v|
      key = k if v[0] == id.to_i
    end
    key
  end

  # returns human readable description of constant
  def description_for(id)
    key = to_key(id)
    @hash[key][1] rescue nil
  end

  # All descriptions
  def descriptions
   @hash.values.collect{|v| v[1]} 	   
  end
  
  # Return array of all int IDs
  def values
     @hash.values.collect{|v| v[0]} 	
  end
    
  # for use as select tag options
  # optionally takes a list of keys if we dont want the entire
  # list of enums as part of the options
  def options(*keys)
    keys.flatten!
    options = []
    if keys.empty?
      options = @hash.values.collect{|row| [row[1],row[0]]}
    else
      keys.each do |k|
        row = @hash[k]
	options << [row[1], row[0]] if row
      end
    end
    options
  end
 
end

