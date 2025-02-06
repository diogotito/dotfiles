# Defined in - @ line 1
function pp --wraps='ping -c4 1.1.1.1' --description 'alias pp=ping -c4 1.1.1.1'
  ping -c4 1.1.1.1 $argv;
end
