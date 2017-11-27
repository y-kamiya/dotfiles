#!/bin/sh

ctags -R -f .git/tags --fields=+iaS --extras=+q --c++-kinds=+p --langmap=c++:+.h $@ `pwd`
