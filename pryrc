# Load plugins (only those I whitelist)
# Pry.config.should_load_plugins = false
# Pry.plugins["doc"].activate!

# Note that this sets up SEPARATE files for each directory Pry is launched from!
Pry.config.history_file = ".pry_history"


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

# Adapted from https://stackoverflow.com/a/11319086/4400644
# The "deep-inspect" Pry command is hereby available under this license:
# https://creativecommons.org/licenses/by-sa/4.0/
Pry::Commands.create_command "deep-inspect" do
  def description
    "Inspect an ActiveRecord object along with all its associations"
  end

  def process
    segments = [object.inspect]
    ActiveRecord::Base.logger.silence do
      segments += inspect_associations
    end
    output.puts segments.compact.join("\n  ")
  end

  private

  def associations
    # Omit belongs_to; we only want to go down the chain, not up.
    associations = object.class.reflect_on_all_associations(:has_one)
    associations += object.class.reflect_on_all_associations(:has_many)
    associations.compact
  end

  def inspect_associations
    associations.map { |association| inspect_association(association) }
  end

  def inspect_association(association)
    result = object.try(association.name)
    if result.is_a?(ActiveRecord::Associations::CollectionProxy)
      collection = result.to_a
      if collection.empty?
        "#{association.name}: #{collection.inspect}"
      else
        collection.inspect
      end
    else
      result.inspect
    end
  end

  def object
    @object ||= eval(args.join(" "))
  end
end