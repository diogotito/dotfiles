# Defined in - @ line 1
function cls --wraps='tput reset' --description 'alias cls tput reset'
  tput reset $argv;
end
