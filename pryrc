# Load plugins (only those I whitelist)
# Pry.config.should_load_plugins = false
# Pry.plugins["doc"].activate!


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
