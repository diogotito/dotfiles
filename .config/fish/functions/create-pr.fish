function create-pr --description 'Create a Pull Request from my new branch, referencing the GH Issue in the branch name'
    gh pr create \
        # --assignee @me \  # no need
        --draft \
        --fill-verbose \
        --editor \
        --title (git branch --show-current \
                   | string replace -ra -- '(?<=[a-z])(?=[A-Z])' ' ' \
                   | string replace -r -- '-\d+$' '' \
                   | string replace -r -- 'feature/ACME(\d+)/(.*)' 'ACME-$1/sirknighttitus: $2')
end
