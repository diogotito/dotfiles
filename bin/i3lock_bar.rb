#!/usr/bin/ruby

require 'ansi/code'

include ANSI::Code

FULL = 0
BEFORE_PARENTHESIS = 1
INSIDE_PARENTHESIS = 2

BOTH = 2

CENTER = 0
LEFT = 1
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

  def expr(n, dim)
    case n
    when Integer ; "#{n < 0 ? dim : ""}#{n}"
    when Float   ; "#{dim}/#{(1/n).round}"
    when String  ; n
    end
  end

  def pos(x, y)
    flags << "#{flag_prefix}pos#{flag_suffix}=#{expr x, 'w'}:#{expr y, 'h'}"
  end

  def rgb(r=0, g=0, b=0, a=255)
    ((r << 24) | (g << 16) | (b << 8) | a).to_s 16
  end

  def method_missing(flag, value=nil)
    flag = flag.to_s.gsub '_', '-'
    if value.nil?
      flags << "#{flag_prefix}#{flag}#{flag_suffix}"
    else
      flags << "#{flag_prefix}#{flag}#{flag_suffix}=#{value}"
    end
    value
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
    define_method(:_) { |name='-', &block|
      suffixes.unshift name
      instance_eval &block
      suffixes.shift
    }
  }
end

def flags_for what, &block
  prefixes = ["--#{what}"]
  such_dry(block) {
    define_method(:flag_prefix) { prefixes.join }
    define_method(:_) { |name='-', &block|
      prefixes.push name
      instance_eval &block
      prefixes.pop
    }
  }
end

def fancy_exec program, &block
  Module.new do
    @flags = []
    %w[misc_flags ending_with flags_for].each do |m|
      singleton_class.define_method m do |*args, &block|
        f_able = Object.method(m).call(*args, &block)  # Call top-level methods
        @flags += f_able.flags
      end
    end
    instance_eval &block
    exec program, *@flags
  end
end


# exec "printf", "[%s]\\n", "i3lock", *[  # dry
# exec "i3lock", *[

fancy_exec 'i3lock' do
  misc_flags do
    bar_indicator
    clock
    composite
    keylayout FULL
    redraw_thread
    refresh_rate 0.1
    spaaaaaaaaaace! :blur, 5
  end

  ending_with '-color' do
    layout '1793D188'
    _ 'hl' do
      bs '4D586E'                            # backspace highlight
      key '5294E2'                           # keystroke highlight
    end
  end

  flags_for 'ind-' do
    pos 683, 75                              # indicator position
  end

  flags_for 'bar-' do                        # fancy soundwave-like bar?
    orientation :horizontal
    pos 0, 10
    base_width 10
    count 50
    color rgb 0x26, 0x2a, 0x32, 0x77
    direction BOTH
    max_height 25
    periodic_step 2
    step 2
  end

  misc_flags do no_verify end                # COMMENT

  flags_for 'date-' do
    color rgb 0x17, 0x93, 0xD1, 0x88
  end

  flags_for 'time' do
    _ do
      color '1793D1'
    end
    _ 'outline-' do
      color '262a3288'
      width 1
    end
  end

  flags_for 'greeter' do                     # random text
    _ do
      text `fortune -s`.lines.map(&:chomp).join
                       .each_char.filter(&:ascii_only?).join
      align CENTER
      pos 0.5, -25
      size rand(10..20)
    end
    _ 'outline-' do
      width 0.4
      color '88aadd'
    end
  end

end

# ].collect_concat(&:flags)

# puts blue{"-[i3lock]-> "} + "Calling #{bold{m}} with #{bold{args}}  --  #{block && green{"(block given)"}}"
# puts "Collected flags:"; pp @flags

