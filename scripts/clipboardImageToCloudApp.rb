#!/usr/bin/env ruby
#
# cl
# Gunar Gessner / @gunar
#
# Uploads an image file from the clipboard to CloudApp, drops it into your 
# clipboard.
#
# This requires Aaron Russell's cloudapp_api gem:
#
#   gem install cloudapp_api
#
# Requires you set your CloudApp credentials in ~/.cloudapp as a simple file of:
#
#   email
#   password

require 'rubygems'
begin
  require 'cloudapp_api'
rescue LoadError
  puts "You need to install cloudapp_api: gem install cloudapp_api"
  exit!(1)
end

config_file = "#{ENV['HOME']}/.cloudapp"
unless File.exist?(config_file)
  puts "You need to type your email and password (one per line) into "+
       "`~/.cloudapp`"
  exit!(1)
end

email,password = File.read(config_file).split("\n")

class HTTParty::Response
  # Apparently HTTPOK.ok? IS NOT OKAY WTFFFFFFFFFFUUUUUUUUUUUUUU
  # LETS MONKEY PATCH IT I FEEL OKAY ABOUT IT
  def ok? ; true end
end

date = Time.now.strftime("%Y-%m-%d-%H-%M-%S")
tmpFile = "/tmp/#{date}.png"

cmd = "xclip -selection clipboard -t image/png -o > #{tmpFile}"
unless system(cmd)
  sleep(1)
  exit!(1)
end

CloudApp.authenticate(email,password)
url = CloudApp::Item.create(:upload, {:file => tmpFile}).url

# Say it for good measure.
puts "Uploaded to #{url} ."

# Get the embed link.
url = "#{url}/#{tmpFile.split('/').last}"

# Copy it to your clipboard.
system("echo '#{url}' | tr -d \"\n\" | xclip -selection clipboard")

sleep(4)

exit!(0)
