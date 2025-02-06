# Defined in - @ line 1
function l --wraps='ls -lF' --description 'alias l ls -lF'
  ls -lF $argv;
end
