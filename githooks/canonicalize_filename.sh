#!/bin/sh

canonicalize_filename () {
    local target_file="$1"
    local physical_directory=""
    local result=""

    # Need to restore the working directory after work.
    local working_dir="`pwd`"

    cd -- "$(dirname -- "$target_file")"
    target_file="$(basename -- "$target_file")"

    # Iterate down a (possible) chain of symlinks
    while [ -L "$target_file" ]
    do
        target_file="$(readlink -- "$target_file")"
        cd -- "$(dirname -- "$target_file")"
        target_file="$(basename -- "$target_file")"
    done

    # Compute the canonicalized name by finding the physical path
    # for the directory we're in and appending the target file.
    physical_directory="`pwd -P`"
    result="$physical_directory/$target_file"

    # restore the working directory after work.
    cd -- "$working_dir"

    echo "$result"
}
