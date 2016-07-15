require_relative "reader.rb"


describe FileParser do 

	context "manipulate file contents" do
    	before(:each) do
      		@file_parser = FileParser.new
      		@file1 = "nope.txt"
      		@file2 = "comma.txt"
      		@line = "Abercrombie, Neil, Male, Tan, 2/13/1943\n"
    	end
    	it 'does not read non-matching file names' do
      	final_list = @file_parser.parse_content(@file1, @line)
      	expect(final_list).to eq nil
    	end

    	it 'reads matching file names' do
      		final_list = @file_parser.parse_content(@file2, @line)
      		expect(final_list).to be_a(Array)
    	end
  	end


	context "verifying first output" do
		before(:each) do
			@final_list = [{"lastname": "Abercrombie", "firstname": "Neil", "gender": "Male", "birthday": "2/13/1943", "color": "Tan"}, {"lastname": "Smith", "firstname": "Steve", "gender": "Male", "birthday": "3/3/1985", "color": "Red"}, {"lastname": "Kournikova", "firstname": "Anna", "gender": "Female", "birthday": "6/3/1975", "color": "Red"}]
		end
		it "first person is female" do
			sorted_list = @final_list.sort_by{|person| [person[:gender], person[:lastname]]}
			gender = sorted_list.first[:gender]
			expect(gender).to eq "Female"
		end
		it "second person is male" do
			sorted_list = @final_list.sort_by{|person| [person[:gender], person[:lastname]]}
			gender = sorted_list[1][:gender]
			expect(gender).to eq "Male"
		end
		it "last person's last name is Smith" do
			sorted_list = @final_list.sort_by{|person| [person[:gender], person[:lastname]]}
			lastname = sorted_list.last[:lastname]
			expect(lastname).to eq "Smith"
		end
	end

	context "verifying second output" do
		before(:each) do
			@final_list = [{"lastname": "Bishop", "firstname": "Timothy", "gender": "Male", "birthday": "4/23/1967", "color": "Yellow"}, {"lastname": "Hingus", "firstname": "Martina", "gender": "Female", "birthday": "4/2/1979", "color": "Green"}, {"lastname": "Bonk", "firstname": "Radek", "gender": "Male", "birthday": "6/3/1975", "color": "Green"}]
		end
		it "first person's birhday is 4/23/1967" do
			sorted_list = @final_list.sort_by{|person| [person[:birthday][-4..-1], person[:lastname]]}
			birthday = sorted_list.first[:birthday]
			expect(birthday).to eq "4/23/1967"
		end
		it "last person's last name is Hingus" do
			sorted_list = @final_list.sort_by{|person| [person[:birthday][-4..-1], person[:lastname]]}
			lastname = sorted_list.last[:lastname]
			expect(lastname).to eq "Hingus"
		end
	end

	context "verifying third output" do
		before(:each) do
				@final_list = [{"lastname": "Kelly", "firstname": "Sue", "gender": "Female", "birthday": "7/12/1959", "color": "Pink"}, {"lastname": "Seles", "firstname": "Monica", "gender": "Female", "birthday": "12/2/1973", "color": "Black"}, {"lastname": "Bouillon", "firstname": "Francis", "gender": "Male", "birthday": "6/3/1975", "color": "Blue"}]
			end
			it "first person's last name is Seles" do
				sorted_list = @final_list.sort_by{|person| person[:lastname]}.reverse
				lastname = sorted_list[0][:lastname]
				expect(lastname).to eq "Seles"
			end
			it "last person's last name is 'Bouillon" do
				sorted_list = @final_list.sort_by{|person| person[:lastname]}.reverse
				lastname = sorted_list[2][:lastname]
				expect(lastname).to eq "Bouillon"
			end
		end



end