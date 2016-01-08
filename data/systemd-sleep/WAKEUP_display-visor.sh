#!/bin/sh
case $1/$2 in
  post/*)
    pkill -x -RTMIN+5 display-visor
    ;;
esac
