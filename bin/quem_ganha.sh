echo 'Nome de autor                | Commits | Linhas afetadas'
echo '----------------------------------------------------------------------'

for pessoa in 'Diogo Tito Vitor Marques' 'Diogo Almiro' 'Susana Gamito'; do
    NLINES=$(git log --pretty='%an' | grep --count "$pessoa")
    printf '%-28s | %7d | %d' "$pessoa" $NLINES
    minhas_linhas.sh "$pessoa"
done | sort -rk 2

