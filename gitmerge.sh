### Shell script for performing GitHub merge commands to master branch ###

#!/bin/sh

mkdir /root/.ssh
chmod 700 /root/.ssh

cp /secrets/flux/id_rsa /root/.ssh/id_rsa
chmod 600 /root/.ssh/id_rsa
ssh-add ~/.ssh/id_rsa

cat <<\EOF >> ~/.ssh/config
#Deployment repo
Host github.com-$GITHUB_ORG_NAME/$TARGET_REPO_NAME
	HostName github.com
	User git
	IdentityFile ~/.ssh/id_rsa
EOF

git remote add origin git@github.com:$GITHUB_ORG_NAME/$TARGET_REPO_NAME.git
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
