require 'zip-code'

texts = Dir.glob("./texts/*")

if texts.empty?
  puts "textsフォルダーがみつかりません"
  exit
end
texts.map{|str|
  str.gsub(/texts/ , 'texts') + '.txt'
}
