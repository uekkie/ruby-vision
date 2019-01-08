images = Dir.glob("#{ARGV.first}")

if images.empty?
  puts "対象ファイルがみつかりません"
  exit
end
images = images.select{|file| !File.exist?("#{file}.txt")}.take(10)

if images.empty? then
  p '処理対象なし'
  exit
end

texts = images.map{|path| "#{path}.txt"}

require "google/cloud/vision"

image_annotator_client = Google::Cloud::Vision::ImageAnnotator.new(version: :v1)
response = image_annotator_client.document_text_detection(images: images)

response.responses.each_with_index do |result, index|
  File.open(texts[index], 'w') do |file|
    puts "processing ... #{file.path}"
    puts result.text_annotations.first&.description.slice(1,5)
    file.puts result.text_annotations.first&.description
    puts "done!"
  end
end
