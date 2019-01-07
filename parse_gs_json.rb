def detect_pdf_gcs gcs_destination_uri:
  require "google/cloud/storage"

  storage = Google::Cloud::Storage.new

  bucket_name, prefix = gcs_destination_uri.match("gs://([^/]+)/(.+)").captures
  bucket              = storage.bucket bucket_name

  puts "Output files:"
  blob_list = bucket.files prefix: prefix
  blob_list.each do |file|
    puts file.name
  end

  output      = blob_list[0]
  json_string = output.download
  response    = JSON.parse(json_string.string)

  # The actual response for the first page of the input file.
  first_page_response = response["responses"][0]
  annotation          = first_page_response["fullTextAnnotation"]

  puts "Full text:\n#{annotation['text']}"
end

if __FILE__ == $PROGRAM_NAME
  if ARGV.size == 1
    detect_pdf_gcs gcs_destination_uri: ARGV.shift
  else
    puts <<~USAGE
      Usage: ruby detect_pdf.rb [document gcs file path] [output gcs file path]
      Example:
        ruby detect_pdf.rb gs://my-bucket/example.pdf gs://my-bucket/prefix_
    USAGE
  end
end
