#!/bin/sh

DIR=$(pwd)

echo "Deleting old publication"
rm -rf public
mkdir public

echo "Removing existing files"
rm -rf public/*

echo "Restore changes in theme"
cd $DIR/themes/uBlogger && git restore . && cd $DIR

echo "Replacing styles from website header and title"
cd $DIR/themes/uBlogger/layouts/partials && sed -i 's/&nbsp;|//' footer.html && cd $DIR
cd $DIR/themes/uBlogger/assets/css/ && sed -i "$(($(cat _ublogger.scss | grep -n post-update | cut -d':' -f1) + 1))a\  display: none;" _ublogger.scss && sed -i 's/contain/cover/' _core/_base.scss && cd $DIR

echo "Generating site"
hugo

echo "Restore changes in theme"
cd $DIR/themes/uBlogger && git restore . && cd $DIR
