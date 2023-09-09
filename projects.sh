#!/bin/bash

PROJECT="$1"

die() {
    echo "$@" > /dev/stderr
}

# set it as you want
run_project() {
    PROJECT_NAME="$1"

    # check if the code editor executable file is empty
    if ! (echo "$MY_EDITOR" | grep '\S' > /dev/null); then
        die "I don't know how to run your favorite code editor. 
Please set the \`MY_EDITOR\` env variable
or edit this script and set a command for editing"
        exit 1
    fi

    PROJECT_PATH="$MY_PROJECT_DIR/$PROJECT_NAME"

    if [ ! -d "$PROJECT_PATH" ]; then
        die "$PROJECT_NAME: project not found"
        return 1
    fi

    $MY_EDITOR "$PROJECT_PATH"
}

latest_commit_time() {
    git -C "$1" log -n 1 --date relative --pretty='%ad' 2>/dev/null

    return $?
}

list_projects() {
    if [ -z "$MY_PROJECT_DIR" ]; then
        die "Please provide the \`MY_PROJECT_DIR\` env variable"
        exit 1
    fi

    for PROJECT in "$MY_PROJECT_DIR"/*; do
        NAME=$(basename "$PROJECT")
        COMMIT_TIME=$(latest_commit_time "$PROJECT")

        printf "%-25s%s\n" "$NAME" "$COMMIT_TIME"

        
    done
}

# list project directory if no project provided
if [ -z "$PROJECT" ]; then
    list_projects
    exit
fi

run_project "$PROJECT"
