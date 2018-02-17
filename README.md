# spellcheckcli
A command line for Source Code spell check.

## Install
1. Download from https://github.com/WANGjieJacques/spellcheckcli/blob/master/Product/spellcheck?raw=true,
or you can compile download the souce code and compile it by yourself.
2. Put the `spellcheckcli` to the `~/bin`.
3. Add `export PATH=$PATH:~/bin` to your ~/.bashrc or ~/.zshrc

## Example usage:
1. spell check the files by fileName.
    `spellcheck file1, file2...`
2. spell check the uncommited swfit file.
    `git diff --only-name|grep .swift|xargs spellcheck`
