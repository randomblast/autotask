#!/usr/bin/ruby

class SourceFile

  attr_accessor :comments # Array of comment bodies that we've parsed

  

  @filename
  @f # File pointer

  # Comment-finding regexes
  @@r_comments = {
    "hash" => /#(.*)$/,
    "inline_c" => /\/\/(.*)$/,
    "multiline_c" => /\/\*(.*?)\*\//m
  }

  # Type finding regexes ("ext" => [regexes])
  @@r_type_first_lines = {
    "php" => [/^#!\/.*php.*$/, /^\<\?/],
    "js" => []
  }

  # Comment forms to expect in each type
  @@types = {
    "php" => ["hash", "inline_c", "multiline_c"]
  }

  # Pattern to strip non-code text from files
  @@r_not_code = {
    #         Start -> <?      ?> -> <?      " -> "      ' -> '             Heredoc
    "php" => [/^.*?\<\?/m, /\?\>.*?\<\?/m, /\".*?\"/m, /\'.*?\'/m, /<<<([A-Z]+).*\n\\1/m]
  }

  def initialize(filename)
    @comments = Array.new
    @filename = filename
    @f = File.open(filename, 'r');

    return if !self.type
    return if !@@types[self.type]

    code = @f.read

    if @@r_not_code[self.type]
      @@r_not_code[self.type].each do |r|
        code.gsub!(r, "")
      end
    end

    # Add comments to array
    @@types[self.type].each {|r|
      code.gsub!(@@r_comments[r]) {|m|
        @comments << m
      }
    }
  end

  def type
    @f.seek 0
    line = @f.gets

    # Test first line
    @@r_type_first_lines.each {|ext, regexes|
      regexes.each {|r|
        return ext if r.match line
      }
   }

    # Test extension
    @@r_type_first_lines.each {|ext, regexes|
      return ext if File.fnmatch?("*.#{ext}", @filename)
    }
    
    # Nothing matches
    nil
  end

end


ARGV.each do |file|
  s = SourceFile.new file
end
