class FileParser

	Text_files = ["comma.txt", "pipe.txt", "space.txt"]
	attr_accessor :final_list

	def initialize
		self.final_list = []
		get_file
	end

	def get_file
		Text_files.each{|text_file| get_lines(text_file)}
	end

	def get_lines(text_file)
		File.foreach("testfiles/"+text_file) { |line| parse_content(text_file, line)}
	end


	def parse_content(text_file, line)
		if text_file == "comma.txt"
			modified_content = line.gsub(/\n/, "").split(",\s")
		
			person = {
				"lastname": modified_content[0],
				"firstname": modified_content[1],
				"gender": modified_content[2],
				"birthday": modified_content[4],
				"color": modified_content[3]
			}
			@final_list << person

		elsif text_file == "pipe.txt"
			modified_content = line.gsub(/\n/, "").split("\s|\s")
			person = {
				"lastname": modified_content[0],
				"firstname": modified_content[1],
				"gender": modified_content[3] == "M" ? "Male" : "Female",
				"birthday": modified_content[5].gsub(/-/,"/"),
				"color": modified_content[4]
			}
			@final_list << person
		
		elsif text_file == "space.txt"
			modified_content = line.gsub(/\n/, "").split("\s")
			person = {
				"lastname": modified_content[0],
				"firstname": modified_content[1],
				"gender": modified_content[3] == "M" ? "Male" : "Female",
				"birthday": modified_content[4].gsub(/-/,"/"),
				"color": modified_content[5]
			}
			@final_list << person
		end
	end



def gender_sorted
  puts "\nOutput 1: \n"
  sorted_list = @final_list.sort_by{|person| [person[:gender], person[:lastname]]}
end

def birthday_sorted
	puts "\nOutput 2: \n"
	sorted_list = @final_list.sort_by{|person| [person[:birthday][-4..-1], person[:lastname]]}
end

def lastname_sorted
	puts "\nOutput 3: \n"
	sorted_list = @final_list.sort_by{|person| person[:lastname]}.reverse
end


def outputting(sorted_list)
	sorted_list.each{|hash| print hash.values.join(" "), "\n"}
end


def pretty_list
	outputting(gender_sorted)
	outputting(birthday_sorted)
	outputting(lastname_sorted)
end

end




