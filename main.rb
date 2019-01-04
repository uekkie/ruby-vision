images = Dir.glob("./images/*")

if images.empty?
  puts "imagesフォルダーがみつかりません"
  exit
end
texts = images.map{|str| str.gsub(/images/ , 'texts') + '.txt'}

require "google/cloud/vision"

image_annotator_client = Google::Cloud::Vision::ImageAnnotator.new(version: :v1)
response = image_annotator_client.document_text_detection(images: images)

response.responses.each_with_index do |result, index|
  
  File.open(texts[index], 'w') do |file|
    file.puts result.text_annotations.first.description
  end
end
