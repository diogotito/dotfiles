# Defined in - @ line 1
function gstat --wraps='git show --stat' --wraps='g stat' --description 'alias gstat g stat'
  g stat $argv;
end
