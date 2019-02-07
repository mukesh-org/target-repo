### Shell script for performing GitHub commands to merge content to PR named branch ###

#!/bin/sh

mkdir /root/.ssh
chmod 700 /root/.ssh

cp /secrets/flux/id_rsa /root/.ssh/id_rsa
chmod 600 /root/.ssh/id_rsa
ssh-add ~/.ssh/id_rsa

git config --global user.email "you@example.com"
git config --global user.name "ci-robot"

git remote add origin git@github.com:$GITHUB_ORG_NAME/$TARGET_REPO_NAME.git
ssh-keyscan -H github.com >> ~/.ssh/known_hosts

branch=$PULL_NUMBER
git checkout -b "$branch"
git add .
git commit -m 'kustomize file updated'
git push origin "$branch"
