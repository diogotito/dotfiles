function ls --wraps=eza --wraps='eza --icons -F' --description 'alias ls eza --icons -F'
    eza --group-directories-first --icons -F $argv
end
