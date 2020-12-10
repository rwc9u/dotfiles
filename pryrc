# Load plugins (only those I whitelist)
Pry.config.should_load_plugins = false
# Pry.plugins["doc"].activate!

# Launch Pry with access to the entire Rails stack.
# If you have Pry in your Gemfile, you can pass: ./script/console --irb=pry instead.
# If you don't, you can load it through the lines below :)
rails = File.join Dir.getwd, 'config', 'environment.rb'

if File.exist?(rails) && ENV['SKIP_RAILS'].nil?
  require rails

  if Rails.version[0..0] == "2"
    require 'console_app'
    require 'console_with_helpers'
  elsif Rails.version[0..0] == "3"
    require 'rails/console/app'
    require 'rails/console/helpers'
  else
    warn "[WARN] cannot load Rails console commands (Not on Rails2 or Rails3?)"
  end
end

Pry::Commands.block_command "load-factory-girl", "Load factory girl in the console for testing" do
  if Rails.env.test?
    require 'factory_girl_rails'
    require 'rspec'
    require 'rspec-rails'
    require 'rspec/mocks/standalone' # => if factories need stubs (for remote services for example)

    class Object
       include FactoryGirl::Syntax::Methods # make FG methods available at top level, so you can do `> create :user`
    end

    def reload_factories!
      FactoryGirl.instance_variable_set(:@factories, nil) # => clear loaded factories/sequences
      # FactoryGirl.instance_variable_set(:@sequences, nil)
      load Rails.root.join('spec/factories.rb') # => loads factories again
    end
  end
end

if ENV['TERM'] == 'emacs'
  Pry.config.color = false
  Pry.config.pager = false
  Pry.config.auto_indent = false
end

if defined?(PryByebug)
  Pry.commands.alias_command 'c', 'continue'
  Pry.commands.alias_command 's', 'step'
  Pry.commands.alias_command 'n', 'next'
  Pry.commands.alias_command 'f', 'finish'
end