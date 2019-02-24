#!/usr/bin/env ruby

# from http://errtheblog.com/posts/89-huba-huba

home = File.expand_path('~')

Dir['*'].each do |file|
  next if file =~ /install/ || file =~ /README/
  if file =~ /^[A-Z]/
    target = File.join(home, file)
  else
    target = File.join(home, ".#{file}")
  end
  `ln -ns #{File.expand_path file} #{target}`
end

# `git submodule sync`
# `git submodule update --init --recursive`
