### Shell script for performing GitHub merge commands to master branch ###

#!/bin/sh
set -e

mkdir /root/.ssh
chmod 700 /root/.ssh

cp /secrets/git/target_ssh_secret /root/.ssh/target_ssh_secret
chmod 600 /root/.ssh/target_ssh_secret
ssh-add /root/.ssh/target_ssh_secret

cat <<\EOF >> ~/.ssh/config
Host $TARGET_REPO_NAME github.com
	HostName github.com
	User git
	IdentityFile ~/.ssh/target_ssh_secret
EOF
chmod 400 ~/.ssh/config

git remote add origin git@github.com:"$GITHUB_ORG_NAME"/"$TARGET_REPO_NAME".git
ssh-keyscan -H github.com >> ~/.ssh/known_hosts

branch="$PULL_NUMBER"

## resolve any merge conflicts if there are any
git fetch origin master
git merge FETCH_HEAD

git checkout master
git merge --no-ff "$branch"
git push -u origin master
