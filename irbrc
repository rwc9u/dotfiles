#-*-Ruby-*-
require 'rubygems'
require 'pp'
require 'wirble'
require 'hirb'
# require 'ap'
if RUBY_VERSION[0..2] == "1.9"
  require 'flyrb'
else
  require 'utility_belt'
end
require 'logger'
# add pretty printing support to irb
include PP::ObjectMixin


# load wirble
Wirble.init
Wirble.colorize

# load hirb
Hirb.enable :pager => !(ENV['PAGER'] && "cat" == ENV['PAGER'].split(File::SEPARATOR).last)
Hirb::View.enable

IRB.conf[:AUTO_INDENT] = true

if ENV.include?('RAILS_ENV')
  if !Object.const_defined?('RAILS_DEFAULT_LOGGER')
    require 'logger'
    Object.const_set('RAILS_DEFAULT_LOGGER', Logger.new(STDOUT))
  end

  def sql(query)
    ActiveRecord::Base.connection.select_all(query)
  end

  if ENV['RAILS_ENV'] == 'test'
    require 'test/test_helper'
  end

# for rails 3
elsif defined?(Rails) && !Rails.env.nil?
  if Rails.logger
    Rails.logger =Logger.new(STDOUT)
    ActiveRecord::Base.logger = Rails.logger
  end
  if Rails.env == 'test'
    require 'test/test_helper'
  end
else
  # nothing to do
end

# annotate column names of an AR model
def show(obj)
  y(obj.send("column_names"))
end

puts "> all systems are go wirble/hirb/ap/show <"


class Object
  def local_methods
    (methods - Object.instance_methods).sort
  end
end

# to reload your rails app
# reload!

# hash of http status codes
# ActionController::StatusCodes::STATUS_CODES

# getting rails logs in the console
# ActiveRecord::Base.logger = Logger.new(STDOUT)
# ActiveRecord::Base.clear_active_connections!


IRB.conf[:SAVE_HISTORY] = 1000

# history_file = File.join Dir.pwd, '.console_history'
# if !IRB.conf[:PROMPT][:RVM]
#   IRB.conf[:HISTORY_FILE] = history_file
# else # RVM workaround, code from ~/.rvm/scripts/irbrc.rb
#   # NOTE: messes up your ~/.irb-history
#   # consider editing the rvm script directly
#   if File.exists?(history_file)
#     lines = IO.readlines(history_file).collect { |line| line.chomp }
#     Readline::HISTORY.clear
#     Readline::HISTORY.push(*lines)
#   end

#   Kernel::at_exit do
#     maxhistsize = IRB.conf[:SAVE_HISTORY] || 100
#     history_file = File.join Dir.pwd, ".console_history"
#     lines = Readline::HISTORY.to_a.reverse.uniq.reverse
#     lines = lines[-maxhistsize, maxhistsize] if lines.compact.length > maxhistsize
#     File::open(history_file, "w+") { |io| io.puts lines.join("\n") }
#   end
# end


# def hist
#   puts Readline::HISTORY.entries.split("exit").last[0..-2].join("\n")
# end
