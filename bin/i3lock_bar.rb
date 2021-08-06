#!/usr/bin/ruby

module Flaggable
  attr_reader :flags

  def flag_prefix;
    "--"
  end

  def method_missing(flag, value=nil)
    flag = flag.to_s.gsub '_', '-'
    if value.nil?
      @flags << "#{flag_prefix}#{flag}"
    else
      @flags << "#{flag_prefix}#{flag}=#{value}"
    end
  end

  def spaaaaaaaaaace!(flag, value)
    @flags << "#{flag_prefix}#{flag.to_s}" << value.to_s
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

def flags_for what, &block
  Module.new {
    extend Flaggable
    @flags = []
    singleton_class.define_method(:flag_prefix) {
      "--#{what}-"
    }
    instance_eval &block
    self
  }
end

#                                                
#  Apagar os 2 primeiros argumentos para correr  
#                                                
exec "printf", "[%s]\\n", "i3lock", *[
  flags_for('bar') {
    base_width 10
    color "262a3277"
    direction 2
    max_height 25
    pos "0:10"
    step 2
  },
  flags_for('date') {
    color "1793D188"
  },
  misc_flags {
    spaaaaaaaaaace! :blur, 5
    bar_indicator
    clock
    composite
  },
].collect(&:flags).flatten

puts '-'*30
pp %w(i3lock
    --bshl-color=4D586E
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

