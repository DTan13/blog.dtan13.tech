#!/bin/sh

DIR=$(pwd)

if [[ $(git status -s) ]]; then
    echo "The working directory is dirty. Please commit any pending changes."
    exit 1
fi

echo "Deleting old publication"
rm -rf public
mkdir public
git worktree prune
rm -rf .git/worktrees/public/

echo "Checking out gh-pages branch into public"
git worktree add -B gh-pages public origin/gh-pages

echo "Removing existing files"
rm -rf public/*

echo "Replacing styles from website header and title"
cd $DIR/themes/uBlogger/layouts/partials && sed -i 's/&nbsp;|//' footer.html && cd $DIR
cd $DIR/themes/uBlogger/assets/css/ && sed -i "$(($(cat _ublogger.scss | grep -n post-update | cut -d':' -f1) + 1))a\  display: none;" _ublogger.scss && cd $DIR

echo "Generating site"
hugo

echo "Restore changes in theme"
cd $DIR/themes/uBlogger && git restore . && cd $DIR

echo "Updating gh-pages branch"
cd public && git add --all && git commit -m "Publishing to blog.dtan13.tech" && cd ..
