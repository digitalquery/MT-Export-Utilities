#!/usr/bin/env ruby



# scans through a file and downloads any images

require 'rubygems'
require 'net/http'
require 'rio'


if ARGV.length != 2
  puts "Usage: extract_images [input_file] [output directory] "
  exit 0
end  

input_file = ARGV[0]
output_dir = ARGV[1].dup

# add trailing slash if needed
output_dir << '/' if output_dir[-1] != '/'

if ! File.file?(ARGV[0])
  puts "Error: input file <#{input_file}> does not exist"
  exit 0
end

if !File.exists?(ARGV[1])
  puts "Error: output directory <#{output_dir}> does not exist"
  exit 0
end

file = File.open(input_file)

s = file.read

images=s.scan(/img .*src="(.+[gGfFpP])" w/)

images.each {|image| 
  
  filename = URI.unescape(File.basename(image.to_s))
  
  # check whether image exists
  if File.exists?(output_dir+filename.to_s) then
    puts "Warning: File #{filename} already exists \n" 
  else
    puts "Downloading " + URI.unescape(image.to_s) + " to " + filename.to_s
    rio(image.to_s) > rio(output_dir+filename.to_s)
  end

  }






