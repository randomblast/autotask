#!/usr/bin/ruby

class SourceFile
  attr_accessor :comments, :filename

  @f # File pointer

  # Comment-finding regexes
  @@r_comments = {
    "hash" => /^[^#]*#(.*)$/,
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
    "php" => ["multiline_c", "inline_c", "hash"]
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

    # Strip non-code text and replace with blank lines
    if @@r_not_code[self.type]
      @@r_not_code[self.type].each {|r|
        code.gsub!(r) {|m|
          "\n" * m.count("\n")
        }
      }
    end

    # Add comments to array
    @@types[self.type].each {|rid|
      r = @@r_comments[rid]

      while
        code.gsub!(/(.*)(#{r})/m) {|m|
          @comments << Comment.new($3, $1.count("\n") + 2) # TODO Find out why this number is 2 short
          $1 << ("\n" * $2.count("\n"))
        }
      end
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

class Comment < String
  attr_accessor :ln

  def initialize(body, ln)
    @ln = ln
    super(body)
  end
end

class Issue
  attr_accessor :filename, :ln, :message, :type, :n

  def initialize(filename, ln, message, type = "todo", n = nil)
    @filename = filename
    @ln = ln
    @message = message.strip
    @type = type.downcase
    @n = n.to_i if n
  end

  def to_s
    if @n
      i = sprintf(" (#%d)", @n)
    else
      i = ""
    end

    return sprintf("%s:%d\t%s%s\n", @filename, @ln, @message, i);
  end
end

issues = []
ARGV.each do |file|
  s = SourceFile.new file

  s.comments.each {|c|
    c.scan(/^.*?(TODO|FIXME)( #([0-9]+))?(.*)$/i)
    issues << Issue.new(s.filename, c.ln, $4, $1, $3);
  }
end

puts issues
