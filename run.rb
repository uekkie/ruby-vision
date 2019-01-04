Dir.open("images") do |dir|
  dir.each do |file|
    puts "#{dir.to_path}/#{file}"
  end
end
