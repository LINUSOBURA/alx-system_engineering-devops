#!/usr/bin/env ruby

def match_school(argument)
	regex = /School+/
	result = argument.scan(regex)

	if result.any?
		matched_string = result.flatten
		puts "#{matched_string.join}$"
	else
		puts ""
	end

end
if ARGV.empty?

else
	argument = ARGV[0]

	match_school(argument)
end