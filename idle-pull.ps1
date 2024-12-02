
cd $HOME\Documents\notes

$output = $(git pull --no-rebase)

# Handle non error output as otherwise it gets shown with any exit code by logseq
if ( "$output" -ne "Already up to date." )
{
    # probably error print it to screen
    echo "$output"
}

git add -A