#!/opt/local/bin/ruby2.0 -w
# ERROR
# Copyright Mark Keane, All Rights Reserved, 2010

# Well its a class that handles errors.
class MyErr
	attr_accessor :type, :holder, :method
	def initialize(type, holder, method)
		@type = type
		@holder = holder
		@method = method
	end

  #  Method that is applied to an error object and prints out appropriate error.
  #  Ruby actually has its own error class that you can use, when you grow up.
	def do_it
		if @type == "multiple_answer_error"
			then puts "Error: Item #{@holder} raised #{@type} in #{@method}"
		elsif @type == "not_found_error"
			then puts "Error: #{@holder} was #{@type} in #{@method}"
    elsif @type == "ID Exception in songs"
      then puts "Error: #{@holder} has #{@type} in #{@method}"
    elsif @type == "ID Exception in owners"
      then puts "Error: #{@holder} has #{@type} in #{@method}"
		else puts "Error: Have been given an unknown error type: #{@type}"
		end
	end

  # the method for checking missing id
	def self.file_check(id)
		if id.instance_of?(String) != true
		then raise "Missing or Invalid ID"
    end

	end

  # the method for checking repeat id
	def self.unique_check(id_array,id)
		if id_array.include?(id) == true
			then raise "Repeated ID"
		end
	end
end