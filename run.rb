# Dir.open(ARGV.first) do |dir|
#   dir.each do |file|
#     puts "#{dir.to_path}/#{file}"
#   end
# end

images = Dir.glob("#{ARGV.first}/*")
images.map{ |file| p file }
