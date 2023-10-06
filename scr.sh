function localCommit() {
    git add $1
    git commit -m "$2"
}

MAIN_BR="master"
DEV_BR="develop"
RELEASE_BR="release"
RELEASE_BR_1="release1"
FEATURE1="feature/1_for_next_release"
FEATURE2="feature/2_for_future_release"
FEATURE3="feature/3_for_next_release"

git checkout -b $MAIN_BR
touch initfile.txt
localCommit "initfile.txt" "add: init commit"
git tag -a 0.1 -m "Version 0.1 demo"

#Init develop branch in local repo
git checkout -b $DEV_BR

touch dev.txt
localCommit dev.txt "add: dev commit 1"

echo "first row in dev.txt" >> dev.txt
localCommit dev.txt "fix: dev commit 2"

echo "second row in dev.txt" >> dev.txt
localCommit dev.txt "fix: dev commit 3"

#Init feature branch 1
git checkout -b $FEATURE1

touch feature1.txt
localCommit feature1.txt "add: feature 1 commit 1"

#Go to develop branch
git checkout $DEV_BR

#Init feature branch 2
git checkout -b $FEATURE2

touch feature2.txt
localCommit feature2.txt "add: feature 2 commit 1"

#Go to develop branch
git checkout $DEV_BR

echo "third row in dev.txt" >> dev.txt
localCommit dev.txt "fix: dev commit 4"

#Go to main for hot fix
git checkout $MAIN_BR

#Create to main for hot fix
git checkout -b "hotfix/hotfix_1"

echo "first line in file - hotfix" >> initfile.txt
localCommit initfile.txt "fix: hotfix"

#Merge hotfix in 2 branch
git checkout $MAIN_BR
git merge --no-commit --no-ff "hotfix/hotfix_1"
git commit -m "fix: hotfix"
git tag -a 0.2 -m "Version 0.2 demo"

git checkout $DEV_BR
git merge --no-commit --no-ff "hotfix/hotfix_1"
git commit -m "fix: hotfix in dev"

#Add commits for merge feature 1
git checkout $FEATURE1

echo "first row in feature1.txt" >> feature1.txt
localCommit feature1.txt "fix: feature 1 commit 2"

echo "second row in feature1.txt" >> feature1.txt
localCommit feature1.txt "fix: feature 1 commit 3"

#Go to develop for merge feature1
git checkout $DEV_BR
git merge --no-commit --no-ff $FEATURE1
git commit -m "add: develop merge feature 1"

#Add commit in feature 2
git checkout $FEATURE2

echo "first row in feature2.txt" >> feature2.txt
localCommit feature2.txt "fix: feature 2 commit 2"

#Make release branch 1
git checkout $DEV_BR
git checkout -b $RELEASE_BR

#Add fix in release branch and merge
echo "fourth row in dev.txt" >> dev.txt
localCommit dev.txt "fix: release 1 commit 1"

echo "fifth row in dev.txt" >> dev.txt
localCommit dev.txt "fix: release 1 commit 2"

git checkout $DEV_BR
git merge --no-commit --no-ff $RELEASE_BR
git commit -m "fix: from release 1 to dev"

#Add new feature branch 3 with all commits
git checkout -b $FEATURE3
touch feature3.txt
localCommit feature3.txt "add: feature 2 commit 1"

echo "first row in feature3.txt" >> feature3.txt
localCommit feature3.txt "fix: feature 2 commit 2"

echo "second row in feature3.txt" >> feature3.txt
localCommit feature3.txt "fix: feature 2 commit 3"

#Add commit in feature 2
git checkout $FEATURE2

echo "second row in feature2.txt" >> feature2.txt
localCommit feature2.txt "fix: feature 2 commit 3"

#Add fixes in release branch
git checkout $RELEASE_BR
touch fixRelise.txt
localCommit fixRelise.txt "fix: release 1 commit 3"

echo "first row in fixRelise.txt" >> fixRelise.txt
localCommit fixRelise.txt "fix: release 1 commit 4"

#Merge release in dev
git checkout $DEV_BR
git merge --no-commit --no-ff $RELEASE_BR
git commit -m "fix: from release 1 in dev"

#Merge release in main
git checkout $MAIN_BR
git merge --no-commit --no-ff $RELEASE_BR
git commit -m "add: release 1"
git tag -a 1.0 -m "Version 1.0"

#Add commit in feature 2
git checkout $FEATURE2

echo "third row in feature2.txt" >> feature2.txt
localCommit feature2.txt "fix: feature 2 commit 4"

#Merged features 2 and 3 in develop
git checkout $DEV_BR
git merge --no-commit --no-ff $FEATURE3 $FEATURE2
#git merge --no-commit --no-ff $FEATURE2

git commit -m "add: feature 2 and 3 in dev"

#add release 2 branch
git checkout -b $RELEASE_BR_1
echo "In the end script for create history in repo
      <br>
      Script named - scr.sh
      <br>
      In this init all history)))" >> README.md
localCommit "scr.sh README.md" "add: release 2 commit 1 bash scr for this task"

#Merge in main and develop
git checkout $MAIN_BR
git merge --no-commit --no-ff $RELEASE_BR_1
git commit -m "add: release 2"
git tag -a 2.0 -m "Version 2.0"

git checkout $DEV_BR
git merge --no-commit --no-ff $RELEASE_BR_1
git commit -m "add: release 2"