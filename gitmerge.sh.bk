### Shell script for performing GitHub merge commands to master branch ###

#!/bin/sh
set -e

mkdir -p /root/.ssh
chmod 700 /root/.ssh

cp /secrets/git/targetgit-ssh-secret /root/.ssh/targetgit-ssh-secret
chmod 600 /root/.ssh/targetgit-ssh-secret
eval $(ssh-agent)
ssh-add /root/.ssh/targetgit-ssh-secret

cat <<\EOF >> ~/.ssh/config
Host $TARGET_REPO_NAME github.com
	HostName github.com
	User git
	IdentityFile ~/.ssh/targetgit-ssh-secret
EOF
chmod 400 ~/.ssh/config

git config --global user.email "you@example.com"
git config --global user.name "ci-robot"

branch="$PULL_NUMBER"

## resolve any merge conflicts if there are any
git checkout "$branch"
git pull
git checkout master
git merge --no-ff --no-commit "$branch"
git status
git commit -m "merge $branch branch"
git push -u origin master
