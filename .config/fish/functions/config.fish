function config --wraps='git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME' --description 'alias config git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME'
  git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME $argv
        
end
