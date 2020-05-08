require 'rubygems'
require 'bundler/setup'
require 'json'
Bundler.require(:default)

webhook_domain = 'https://discordapp.com'
webhook_path = ENV['WEBHOOK_PATH']

if webhook_path.nil?
  puts  "no webhook path set"
  return
end

data = {}
raw_content = `apcaccess`
lines = raw_content.split("\n")
lines.each do |line|
  row = line.split(':')
  data[row[0].strip] = row[1].strip
end

important_data = <<EOF
Status
  Status: #{data['STATUS']}
  Charge Amount: #{data['BCHARGE']}
  Power Load: #{data['LOADPCT']}
  Time Left on Battery: #{data['TIMELEFT']}
  Transfers to Battery: #{data['NUMXFERS']}
  Time on Battery: #{data['TONBATT']}
  Total Time on Battery: #{data['CUMONBATT']}
  Battery Date: #{data['BATTDATE']}
EOF

Faraday.new(url: webhook_domain).post(
  webhook_path, {
    content: important_data
  }.to_json,
  {
    'Content-Type' => 'application/json'
  }
)
