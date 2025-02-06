function changed-files
git diff --name-only (git merge-base origin/master HEAD)
end
