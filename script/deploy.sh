#!/bin/bash
set -x
set -o errexit -o nounset

if [ "$TRAVIS_BRANCH" != "master" ]
then
  echo "This commit was made against the $TRAVIS_BRANCH and not the master!"
  exit 0
fi

rev=$(git rev-parse --short HEAD)

cd build

git init
git config user.name "azriel"
git config user.email "azrielproject@gmail.com"

git remote add upstream "https://$GH_TOKEN@github.com/azriel/azriel.github.io.git"
git fetch upstream
git reset upstream/master # Or github-pages

touch .nojekyll
touch .

git add -A .
git commit -m "rebuild pages at ${rev}"
git push -q upstream HEAD:master # Or github-pages
