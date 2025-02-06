function gcb --wraps=pwsh\ gcb\ \|\ string\ trim\ -r\ -c\ \\r\ \|\ string\ collect --wraps=pwsh\ gcb\ \|\ string\ trim\ -r\ -c\ \\r\ \|\ string\ collect\ -N --description alias\ gcb\ pwsh\ gcb\ \|\ string\ trim\ -r\ -c\ \\r\ \|\ string\ collect\ -N
  pwsh gcb | string trim -r -c \r | string collect -N $argv
        
end
