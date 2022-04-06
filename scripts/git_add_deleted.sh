#!/bin/bash

git ls-files --deleted  |sed -e 's/ /\\ /g' |  xargs git add --all
