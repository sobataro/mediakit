#!/usr/bin/env ruby

require "bundler/setup"
require "mediakit"
require 'pry'

def transcode_option(input, output)
  options = Mediakit::FFmpeg::Options.new(
    Mediakit::FFmpeg::Options::GlobalOption.new(
      't' => 100,
      'y' => true,
    ),
    Mediakit::FFmpeg::Options::InputFileOption.new(
      options: nil,
      path:    input,
    ),
    Mediakit::FFmpeg::Options::InputFileOption.new(
      options: nil,
      path:    input,
    ),
    Mediakit::FFmpeg::Options::OutputFileOption.new(
      options: {
        'vf' => 'crop=320:320:0:0',
        'ar' => '44100',
        'ab' => '128k',
      },
      path:    output,
    ),
  )
end

root        = File.expand_path(File.join(File.dirname(__FILE__), '../'))
input_path  = File.expand_path(File.join(root, 'test/fixtures/sample1.mp4'))
output_path = File.expand_path(File.join(root, 'out.mp4'))
driver      = Mediakit::Drivers::FFmpeg.new
ffmpeg      = Mediakit::FFmpeg.new(driver)
options     = transcode_option(input_path, output_path)
puts "$ #{ffmpeg.command(options)}"
puts ffmpeg.run(options)
