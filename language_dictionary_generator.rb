require 'json'

#language_dictionary_generator
File.open('/Users/schandramouli/PycharmProjects/GithubAPI/languages_data_sorted.json') do |file|
  data = file.readlines
  data_string = ""
  data.each {|line| data_string += line.chomp}

  language_data = JSON.parse(data_string)

  # set the LoC for all the languages to 0
  languages = Hash.new(0)

  # now cycle through the list, and add the lines to the respective langs
  # remember, LoC for JS is to be modded by 10 whenever it goes over 10k cuz jQuery
  language_data.each do |key, value|
    value = JSON.parse(value)
    # puts value
    value.each do |lang, loc|
      if lang.equal?("JavaScript")
        loc %= 10
      end
      languages[lang] += loc
    end
  end

  puts languages
end
