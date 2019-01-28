### Shell script for performing GitHub commands ###

#!/bin/sh

git remote add origin git@github.com:$GITHUB_ORG_NAME/$TARGET_REPO_NAME.git
ssh-keyscan -H github.com >> ~/.ssh/known_hosts

branch=$PULL_NUMBER
git checkout -b "$branch"
git add .
git commit -m 'kustomize file updated'
git push origin "$branch"
