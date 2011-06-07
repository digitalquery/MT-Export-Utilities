#!/usr/bin/env ruby


# Takes an input file and a spec file
# input file contains lots of urls that need rewriting
# spec file contains search regex and replace text
# spec file:
# line 1 - general string
# line 2 - general string replacement
# line 3 - img src string
# line 4 - img string rplacement



if ARGV.length != 2
  puts "Usage: rewrite_urls [input_file] [spec_file] "
  exit 0
end  

input_file, spec_file = ARGV[0], ARGV[1]
output_file = input_file.chomp(File.extname(input_file)) + '.rewritten.txt'


if ! File.file?(input_file)
  puts "Error: input file <#{input_file}> does not exist"
  exit 0
end


if ! File.file?(spec_file)
  puts "Error: input file <#{spec_file}> does not exist"
  exit 0
end


# get search and replace strings from the spec_file
search_replace = File.open(spec_file).collect

search_text = search_replace[0].strip
replace_text = search_replace[1].strip


infile = File.open(input_file,"r")
rewrite = File.open(output_file,"w")

infile.each {|line|
  replace = line.gsub(/#{search_replace[0].strip}/,replace_text)
  replace = replace.gsub(/#{search_replace[2].strip}/,search_replace[3].strip)
  rewrite.puts replace
}
  
rewrite.close