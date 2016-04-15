#!/bin/bash
echo "[post page draft]"
echo "https://github.com/jekyll/jekyll-compose"

post(){
  echo "Title?"
  read title
  bundle exec jekyll post $title
}


read input

case $input in
  [post]* ) post;;
  * ) echo "No input";;
esac
