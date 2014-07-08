require 'youtube_it'
require 'chronic_duration'
require 'yaml'

id = ARGV[0]

client = YouTubeIt::Client.new YAML.load_file 'youtube.yml'

video = client.video_by(id)

["video_id", "title", "description", "published_at", "duration"].each do |key|
  value = video.send(key)
  value = value.split(":").last if key == "video_id"
  value = ChronicDuration.output(value, :format => :chrono) if key == "duration"
  puts "===#{key}====="
  puts value
end