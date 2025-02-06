function ll --wraps=ls --wraps='eza --long --git --group --group-directories-first --icons' --wraps='eza --long --group --group-directories-first --icons' --wraps='eza --long --group --group-directories-first --icons -F' --description 'alias ll eza --long --group --group-directories-first --icons -F'
  eza --long --group --group-directories-first --icons -F $argv
        
end
