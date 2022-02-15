#!/bin/bash

set -e

git config --global user.name SymbiFlow
git config --global user.mail robot@mith.ro
git config --global push.default simple

GITHUB_USER=$(echo $GITHUB_REPOSITORY | sed -e's-/.*--')
if [ "x$GITHUB_USER" == "xSymbiFlow" ]; then
  git clone https://${GH_TOKEN}@github.com/SymbiFlow/symbiflow.github.io --branch master build
else
  git clone https://${GH_TOKEN}@github.com/$GITHUB_REPOSITORY --branch gh-pages build
fi
git status

cp -a /tmp/website-build/* build

GIT_DESCRIBE=$(git describe --tags)

cd build

touch .nojekyll
cat > README.md <<EOF
# [SymbiFlow Website](https://symbiflow.github.io)

Built from [$GITHUB_REPOSITORY $GIT_DESCRIBE](https://github.com/$GITHUB_REPOSITORY/commit/$GITHUB_SHA)

# Commit Message

$COMMIT_MESSAGE
EOF

echo '> Add'
git add --all .

echo '> Status'
git status

echo '> Prepare commit message'
echo "Updating to $GIT_DESCRIBE." > /tmp/git_commit
echo >> /tmp/git_commit
echo "$COMMIT_MESSAGE" >> /tmp/git_commit

echo '> Commit'
git commit -F /tmp/git_commit

echo '> Log'
git log

echo '> Push'
git push origin
