# spellcheckcli
A command line for Source Code spell check.


## Example usage:
1. spell check the files by fileName.
    `spellcheck file1, file2...`
2. spell check the uncommited swfit file.
    `git diff --only-name|grep .swift|xargs spellcheck`
