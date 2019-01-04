require 'zip_code_jp'

if ARGV.first != nil then
  address = ZipCodeJp.find ARGV.first
  if address != false then
    puts address.to_yaml
  end
end
