# git

```console
git clone git@github.com:cal2227/EDAV_Project_Class.git
cd EDAV_Project_Class.git
git remote -v
git remote add alex git@github.com:MakarAl/EDAV_Project_Class.git
git co -b mybr 
git br
touch readme_notes.md
git add readme_notes.md
git status
git ci -m ""
git log
git co master
git co -b local
git st
git push origin mybr
git push origin
git mg --no-ff local
git config branch.master.mergeoptions  "--no-ff"
git config branch.mybr.mergeoptions  "--no-ff"
git mg master
git reset --soft origin/master
git fetch alex
git mg alex/master
```

####From ~/.gitconfig
```
[alias]
  ad = add .
  br = branch
  mg = merge
  co = checkout
  st = status -s
  ci = commit -a
  lg = log --color --graph --pretty=format:'%Cred%h%Creset - %C(yellow)%d%Creset%s%Cgreen(%cr)%C(bold blue)<%an>%Creset'
[push]
  default = current
```

####From .git/config
```
[branch "master"]
  remote = origin
  merge = refs/heads/master
  mergeoptions = --no-ff
[remote "alex"]
  url = git@github.com:MakarAl/EDAV_Project_Class.git
  fetch = +refs/heads/*:refs/remotes/alex/*
[branch "mybr"]
  mergeoptions = --no-ff
```

####From ~/.bashrc
```shell
function parse_git_branch {
      ref=$(git symbolic-ref HEAD 2> /dev/null) || return
      echo ${ref#refs/heads/}
}

function parse_git_name {
      ref=$(git config --local remote.origin.url | sed -n 's#.*/\([^.]*\)\.git#\1#p') || return
      echo ${ref}
}

function git_info {
    name=$(parse_git_name)
    branch=$(parse_git_branch)
    if [ "${name}" -a "${branch}" ]; then
      echo "[${name} ${branch}] "
    fi
}

export PS1="\$(git_info)\W $ "
```

