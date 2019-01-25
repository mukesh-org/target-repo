### Shell script for performing GitHub merge commands to master branch ###

#!/bin/sh

cp /secrets/flux/id_rsa /root/.ssh/id_rsa
chmod 600 /root/.ssh/id_rsa
ssh-add ~/.ssh/id_rsa

git remote add origin git@github.com:mukesh-org/config-repo.git
ssh-keyscan -H github.com >> ~/.ssh/known_hosts

branch=$PULL_NUMBER
git checkout -b "$branch"
git add .
git commit -m 'kustomize file updated'
git push origin "$branch"

## resolve any merge conflicts if there are any
git fetch origin master
git merge FETCH_HEAD

git checkout master
git merge --no-ff "$branch"
git push -u origin master
