# this script creates a README.md file
# with a table of contents, with references to the files

all_files =  Dir.entries(".")

hidden_files = [".", "..", ".DS_Store", "script.rb", "img", ".git", ".gitignore", "README.md", "Additional Notes.md"]

files = all_files - hidden_files

intro = "# My Notes\n\nThese are my notes I wrote while working as an incircuit testing [ICT] coop at Sanmina. They encompass the most important things, as well as a general overview on how to use the Keysight 3070 for ICT.\n\n"

table = "## Table of Contents\n\n"

text = intro + table

files.sort!

files.each do |f|
	file_name = "[#{f}]"
	file_path = "(#{f})"
	file_path.gsub!(" ", "%20")		# replace all spaces with %20 [for html rendering]
	file_name.gsub!(".md]", "]")	# remove file extension
	text += "- #{file_name}#{file_path}\n"
end

File.open("README.md", "w") { |file| file.write(text) }