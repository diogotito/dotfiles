#!/usr/bin/ruby

FULL = 0
BEFORE_PARENTHESIS = 1
INSIDE_PARENTHESIS = 2

BOTH = 2
RIGHT = 2

# DSL

module Flaggable
  def flags
    @flags ||= []
  end

  def flag_prefix
    "--"
  end

  def flag_suffix
    ""
  end

  def pos(x, y)
    x = "w#{x}" if x < 0
    y = "h#{y}" if y < 0
    flags << "#{flag_prefix}pos#{flag_suffix}=#{x}:#{y}"
  end

  def rgb(r, g, b, a=255)
    ((r << 24) | (g << 16) | (b << 8) | a).to_s 16
  end

  def method_missing(flag, value=nil)
    flag = flag.to_s.gsub '_', '-'
    if value.nil?
      flags << "#{flag_prefix}#{flag}#{flag_suffix}"
    else
      flags << "#{flag_prefix}#{flag}#{flag_suffix}=#{value}"
    end
  end

  def spaaaaaaaaaace!(flag, value)
    flags << "#{flag_prefix}#{flag.to_s}" << value.to_s
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

def such_dry(the_other_block, &block)
  Module.new {
    extend Flaggable
    singleton_class.instance_eval &block if block_given?
    instance_eval &the_other_block
    self
  }
end

def misc_flags(&block)
  such_dry block
end

def ending_with what, &block
  suffixes = [what]
  such_dry(block) { |m|
    define_method(:flag_suffix) { suffixes.join }
    define_method(:_) { |name, &block|
      suffixes.unshift name
      instance_eval &block
      suffixes.shift
    }
  }
end

def flags_for what, &block
  prefixes = ["--#{what}"]
  such_dry(block) { |m|
    define_method(:flag_prefix) { prefixes.join }
    define_method(:_) { |name, &block|
      prefixes.push name
      instance_eval &block
      prefixes.pop
    }
  }
end


# exec "printf", "[%s]\\n", "i3lock", *[  # dry
exec "i3lock", *[

  misc_flags {
    bar_indicator
    clock
    composite
    keylayout FULL
    redraw_thread
    refresh_rate 0.1
    spaaaaaaaaaace! :blur, 5
  },

  ending_with('-color') {
    layout '1793D188'
    _('hl') {
      bs '4D586E'   # backspace
      key '5294E2'  # keystroke
    }
  },

  flags_for('ind-') {
    pos 683, 75
  },

  flags_for('bar-') {
    base_width 10
    color rgb 0x26, 0x2a, 0x32, 0x77
    direction BOTH
    max_height 25
    pos 0, 10
    step 2
  },

  flags_for('date-') {
    color rgb 0x17, 0x93, 0xD1, 0x88
  },

  flags_for('greeter-') {
    text 'I :heart: Ruby!'
    align RIGHT
    pos -25, -25
  },

  flags_for('time') {
    _color '1793D1'
    _('outline-') {
      color '262a3288'
      width 1
    }
  },

].collect(&:flags).flatten

