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
  # this sorts by value, yay! minus for descending
  languages = Hash[languages.sort_by { |key, value| -value}]
  puts languages
  File.write('./language_usage_data.json', JSON.pretty_unparse(languages))

  # now to find frequency of usage of a language, ala how
  # many projects with that language.
  frequency = Hash.new(0)
  language_data.each do |key, value|
    value = JSON.parse(value)
    # puts value
    value.each do |lang, loc|
      frequency[lang] += 1
    end
  end
  # this sorts by value, yay! minus for descending
  # frequency = Hash[frequency.sort_by { |key, value| key}.reverse]
  # does the same as -value, but more verbose
  frequency = Hash[frequency.sort_by { |key, value| value}.reverse]
  puts frequency
  File.write('./language_frequency_data.json', JSON.pretty_unparse(frequency))

end
