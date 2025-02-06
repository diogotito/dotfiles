# Defined in /tmp/fish.Hgfclb/ranger-cd.fish @ line 2
function ranger-cd --description ranger-cd
  set -l tmpfile (mktemp /tmp/tmp.ranger.choosedir.XXX)
  ranger --choosedir=$tmpfile
  cd (cat $tmpfile)
  rm $tmpfile
  commandline -f force-repaint
end
