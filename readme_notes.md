
### Learning git

git clone git@github.com:cal2227/EDAV_Project_Class.git
git remote -v
git remote add upstream git@github.com:MakarAl/EDAV_Project_Class.git
git fetch upstream
git co master
git merge upstream/master
git co -b mybr 
git br
touch readme_notes.md
git add readme_notes.md
git st
cit commit -m ""
vim readme_notes.md
git ci -m ""

####~/.gitconfig
[alias]
  ad = add .
  br = branch
  mg = merge
  co = checkout
  st = status -s
  ci = commit -a
  lg = log --color --graph --pretty=format:'%Cred%h%Creset - %C(yellow)%d%Creset%s%Cgreen(%cr)%C(bold blue)<%an>%Creset'
...

####~/.bashrc
...
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
...

### Learning R
