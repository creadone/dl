require "http/client"

class Downloader

  def initialize(link : String, path : String)
    @link = link
    @path = path
  end

  def run
    client = HTTP::Client.get @link
    if client.status_code == 200

      path = URI.parse(@link).path.to_s
      file_name = File.basename(path)

      Dir.mkdir(@path) if !Dir.exists?(@path)

      File.open(File.join(@path, file_name), "wb") do |file|
        file.puts client.body
        puts "#{client.status_message}: #{@link}"
      end

    else
      puts "#{client.status_message}: #{@link}"
    end
  end

end
