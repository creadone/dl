require "./lib/downloader.cr"
require "admiral"

class Dl < Admiral::Command
  define_version "0.1.0"
  define_help description: "dl is utility for download files by URLs from list"
  define_flag list : String, description: "Path to file with URLs", long: list, short: l, required: true
  define_flag output : String, description: "Path to destination folder", long: output, short: o, default: "./"

  def run
    lines = [] of String
    begin
      lines = File.read_lines(flags.list)
    rescue e
      puts e.message; exit
    end

    lines.each do |url|
      begin
        Downloader.new(url, flags.output).run
      rescue e
        puts e.message; next
      end
    end
  end

end

Dl.run
