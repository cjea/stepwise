# frozen_string_literal: true

require_relative 'json_to_html.rb'
require_relative 'parse.rb'

class Main
  attr_accessor :json

  def initialize
    @json = []
  end

  def html(path)
    config = Parse.parse(File.read(path))
    JsonToHtml.new(config).html
  rescue StandardError => e
    puts e
    puts "#{path} isnt a good path"
    exit 1;
  end
end

if ARGV.size < 2
  puts <<-EOF
Render some todos.

  $ todo <todo_path> <out_path>

The <todo_path> file should look like the following.
----------------------------------------------------
: Task to do
  a small description
  {a place for input}
: Other task
  description

EOF
  exit 1;
end

File.write(ARGV[1], Main.new.html(ARGV[0]))
