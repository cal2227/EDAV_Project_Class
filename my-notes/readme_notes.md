### R
```{r, eval=FALSE}
list.files()
setwd('EDAV_Project_Class')
library(xlsx)
df <- read.xlsx(filename, 1, header=T)
table(df[,2])
Program <- unique(df[,2])
df[,2] <- replace(df[,2],df[,2]=="MSDS", "IDSE (master)")
levels(df[,6]) <- c(levels(df[,6]),"Eclipse","TextWrangler","None","Any","Jupyter)
df[,2] <- droplevels(df[,2])
df[grep("Sublime",df[,6], ignore.case = TRUE),6]<-"Sublime"
df[,6] <- droplevels(df[,6])
cleandf<-cbind(df,skillsdf)
```

### git

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
cit ci -m ""
vim readme_notes.md
git ci -m ""
git log
git co master
git co -b local
vim README.md
git ci -m ""
git st
git co mybr
git push origin mybr
git co master
git mg --no-ff master
git config branch.master.mergeoptions  "--no-ff"
git mg local
git co mybr
git config branch.mybr.mergeoptions  "--no-ff"
git mg master
git co master
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

