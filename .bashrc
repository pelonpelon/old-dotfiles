[ -n "$PS1" ] && source ~/.bash_profile

function md {
    if [ ! -n "$1" ]; then
        echo "Enter a directory name"
    elif [ -d $1 ]; then
        echo "\`$1' already exists"
    else
        mkdir $1 && cd $_
    fi
}

