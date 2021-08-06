#!/usr/bin/ruby

module Flaggable
  attr_reader :flags
  def flag_prefix;
    "--"
  end
  def method_missing(flag, value=nil)
    if value.nil?
      @flags << "#{flag_prefix}#{flag}"
    elsif flag.to_s.end_with? "="
      # "--name-flag=value"
      @flags << "#{flag_prefix}#{flag}#{value}"
    else
      # "--name-flag" and "value" separated
      @flags << "#{flag_prefix}#{flag}" \
             << "#{value}"
    end
  end
end

class Flags
  include Flaggable
  def flag_prefix
    "--#{@name}-"
  end
  def initialize(name, &block)
    @name = name
    @flags = []
    instance_eval &block
  end
end

def misc_flags(&block)
  Module.new {
    extend Flaggable
    @flags = []
    instance_eval &block
    self
  }
end

puts '-----------------------------------------'
mf = misc_flags do |_|
  espaco 'separado'
  _.igual = 'agarrado'
end
pp mf
pp mf.flags
puts '-----------------------------------------'

exec "printf", "[%s]\\n", "i3lock", *[
  Flags.new('bar') do |bar|
    bar.base_width = 10
    bar.color = "262a3277"
    bar.direction = 2
    bar.max_height = 25
    bar.pos = "0:10"
    bar.step = 2
  end,
].collect(&:flags).flatten

puts '-'*30
pp %w(i3lock
    --bar-indicator
    --blur 5
    --bshl-color=4D586E
    --clock
    --composite
    --date-color=1793D188
    --greeter-text="${1:-$0}" --greeter-align=2 --greeter-pos="w-25:h-25"
    --ind-pos=683:75
    --keyhl-color=5294E2
    --keylayout 0
    --layout-color=1793D188
    --redraw-thread
    --refresh-rate=0.1
    --time-color=1793D1ff
    --timeoutline-color 262a3288
    --timeoutline-width=1)

