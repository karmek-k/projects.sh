#!/bin/bash

PROJECT="$1"

die() {
    echo "$@" > /dev/stderr
}

# set it as you want
run_project() {
    PROJECT_NAME="$1"

    # check if the code editor executable file is empty
    echo "$MY_EDITOR" | grep '\S' > /dev/null
    if [ "$?" != 0 ]; then
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

    $MY_EDITOR $PROJECT_PATH
}

# list project directory if no project provided
if [ -z "$PROJECT" ]; then
    if [ -z "$MY_PROJECT_DIR" ]; then
        die "Please provide the \`MY_PROJECT_DIR\` env variable"
        exit 1
    fi

    ls -1 $MY_PROJECT_DIR
    exit
fi

run_project $PROJECT
