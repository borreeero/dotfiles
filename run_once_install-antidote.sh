#!/usr/bin/env sh

test -d ~/.antidote && exit

git clone --depth=1 https://github.com/mattmc3/antidote.git ~/.antidote

