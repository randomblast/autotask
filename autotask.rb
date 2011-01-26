#!/usr/bin/ruby

class SourceFile

  # Array of comment bodies that we've parsed
  @comments

  # File pointer
  @f

  # Comment-finding regexes
  $r_comments = {
    "hash" => /#(.*)$/,
    "inline_c" => /\/\/(.*)$/,
    "multiline_c" => /\/\*(.*?)\*\//m
  }

  # Type finding regexes
  $r_type_first_lines = {
    "php" => [/^#!\/.*php.*$/, /^\<\?/]
  }

  # Comment forms to expect in each type
  $types = {
    "php" => [$r_comments['hash'], $r_comments['inline_c'], $r_comments['multiline_c']]
  }

  def initialize(filename)
   @f = File.open(filename, 'r'); 
  end

  def type
    # Test first line
    @f.seek 0
    line = @f.gets
    $r_type_first_lines.each do |t|
      t.each do |t,r|
        puts r.match? line
      end
    end


    # Test extension
  end

  def tasks
  end

end

def parse(file)
  puts file
end

ARGV.each do |file|
  s = SourceFile.new file
  puts s.type
end
