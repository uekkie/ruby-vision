images = Dir.glob("#{ARGV.first}")

if images.empty?
  puts "対象ファイルがみつかりません"
  exit
end

require "google/cloud/vision"

loop do
  targets = images.select{|file| !File.exist?("#{file}.txt")}.take(5)

  if targets.empty? then
    p '完了'
    exit
  end

  texts = targets.map{|path| "#{path}.txt"}

  image_annotator_client = Google::Cloud::Vision::ImageAnnotator.new(version: :v1)
  response = image_annotator_client.document_text_detection(images: targets)

  response.responses.each_with_index do |result, index|
    File.open(texts[index], 'w') do |file|
      puts "processing ... #{file.path}"
      puts result.text_annotations.first&.description.slice(1,5)
      file.puts result.text_annotations.first&.description
      puts "done!"
    end
  end

  sleep 1
end
