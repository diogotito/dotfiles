# Defined in - @ line 1
function gsh --wraps='git sh' --description 'alias gsh git sh'
  git sh $argv;
end
