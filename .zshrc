# git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
# ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
ZSH_THEME="spaceship"

# git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
# git clone https://github.com/agkozak/zsh-z $ZSH_CUSTOM/plugins/zsh-z
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  zsh-z
)

# https://ohmyz.sh/
export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

# -------------------------------- #
# Node Package Manager
# -------------------------------- #
# https://github.com/antfu/ni

alias nio="ni --prefer-offline"
alias s="nr start"
alias d="nr dev"
alias b="nr build"
alias bw="nr build --watch"
alias t="nr test"
alias tu="nr test -u"
alias tw="nr test --watch"
alias w="nr watch"
alias p="nr play"
alias tc="nr typecheck"
alias lint="nr lint"
alias lintf="nr lint --fix"
alias release="nr release"
alias re="nr release"

# -------------------------------- #
# Git
# -------------------------------- #

# Use github/hub
alias git=hub

# Go to project root
alias grt='cd "$(git rev-parse --show-toplevel)"'

alias gs='git status'
alias gp='git push'
alias gpf='git push --force'
alias gpft='git push --follow-tags'
alias gpl='git pull --rebase'
alias gcl='git clone'
alias gst='git stash'
alias grm='git rm'
alias gmv='git mv'

alias main='git checkout main'

alias gco='git checkout'
alias gcob='git checkout -b'

alias gb='git branch'
alias gbd='git branch -d'

alias grb='git rebase'
alias grbom='git rebase origin/master'
alias grbc='git rebase --continue'

alias gl='git log'
alias glo='git log --oneline --graph'

alias grh='git reset HEAD'
alias grh1='git reset HEAD~1'

alias ga='git add'
alias gA='git add -A'

alias gc='git commit'
alias gcm='git commit -m'
alias gca='git commit -a'
alias gcam='git add -A && git commit -m'
alias gfrb='git fetch origin && git rebase origin/master'

alias gxn='git clean -dn'
alias gx='git clean -df'

alias gsha='git rev-parse HEAD | pbcopy'

alias ghci='gh run list -L 1'

alias gii='git_init_ignore'

# 自动生成.gitignore
ignore() {
  if [ -f ".gitignore" ]; then
    logRed ".gitignore已存在"
    return
  fi
  logGreen "...正在生成.gitignore"
  touch .gitignore
  echo "*.DS_Store  \nnode_modules \n*.log \nidea/ \n*.local \n.DS_Store \ndist \n.cache \n.idea \nlogs \n&-debug.log \n*-error.log \n*__pycache__/" >>.gitignore
}

function git_init_ignore() {
  git init "$@"
  echo "*.DS_Store  \nnode_modules \n*.log \nidea/ \n*.local \n.DS_Store \ndist \n.cache \n.idea \nlogs \n*-debug.log \n*-error.log" >> .gitignore
}

function glp() {
  git --no-pager log -$1
}

function gd() {
  if [[ -z $1 ]] then
    git diff --color | diff-so-fancy
  else
    git diff --color $1 | diff-so-fancy
  fi
}

function gdc() {
  if [[ -z $1 ]] then
    git diff --color --cached | diff-so-fancy
  else
    git diff --color --cached $1 | diff-so-fancy
  fi
}

#--------------------------#
# console color
# -------------------------#

RED='\e[1;31m'     # 红
GREEN='\e[1;32m'   # 绿
YELLOW='\e[1;33m'  # 黄
BLUE='\e[1;34m'    # 蓝
PINK='\e[1;35m'    # 粉红
SKYBLUE='\e[1;96m' # 紫
RES='\e[0m'        # 清除颜色

color () {  # 设置颜色
  gum style --foreground "$1" "$2"
}

#--------------------------#
# Other
# -------------------------#
alias zshrc="source ~/.zshrc"
#--------------------------#
# Functions
# -------------------------#

logRed() {
  echo -e "${RED} $* ${RES}"
}

logGreen() {
  echo -e "${GREEN} $* ${RES}"
}

logYellow() {
  echo -e "${YELLOW} $* ${RES}"
}

logBlue() {
  echo -e "${BLUE} $* ${RES}"
}

logSkyblue() {
  echo -e "${SKYBLUE} $* ${RES}"
}
logPink() {
  echo -e "${PINK} $* ${RES}"
}

# -------------------------------- #
# Directories
#
# I put
# `~/i` for my projects
# `~/f` for forks
# `~/r` for reproductions
# -------------------------------- #

function i() {
  cd ~/i/$1
}

function repros() {
  cd ~/r/$1
}

function forks() {
  cd ~/f/$1
}

function pr() {
  if [ $1 = "ls" ]; then
    gh pr list
  else
    gh pr checkout $1
  fi
}

function dir() {
  mkdir $1 && cd $1
}

function clone() {
  if [[ -z $2 ]] then
    hub clone "$@" && cd "$(basename "$1" .git)"
  else
    hub clone "$@" && cd "$2"
  fi
}

# Clone to ~/i and cd to it
function clonei() {
  i && clone "$@" && code . && cd ~2
}

function cloner() {
  repros && clone "$@" && code . && cd ~2
}

function clonef() {
  forks && clone "$@" && code . && cd ~2
}

function ci() {
  i && code "$@" && cd -
}

function serve() {
  if [[ -z $1 ]] then
    live-server dist
  else
    live-server $1
  fi
}
source /opt/homebrew/opt/spaceship/spaceship.zsh

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/Caskroom/miniconda/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# PATH Configuration
# Adding directories to PATH for various tools and utilities
export PATH="/usr/local/opt/ruby/bin:/opt/homebrew/opt/ruby/bin:/opt/homebrew/bin:/opt/homebrew/Caskroom/miniconda/base/bin:/opt/homebrew/opt/node@14/bin:$PATH"

# NVM Initialization
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Additional User Configurations (if any)

export PATH="/opt/homebrew/opt/node@14/bin:$PATH"
export PATH="/usr/local/opt/ruby/bin:$PATH"
export PATH="/usr/local/opt/ruby/bin:$PATH"
export PATH="/usr/local/opt/ruby/bin:$PATH"
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/miniconda/bin:$PATH"
export JAVA_HOME="/Library/Java/JavaVirtualMachines/zulu-11.jdk/Contents/Home"

# bun completions
[ -s "/Users/huyixi/.bun/_bun" ] && source "/Users/huyixi/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"
export JAVA_HOME=/opt/homebrew/Cellar/openjdk@17/17.0.9/libexec/openjdk.jdk/Contents/Home
source /opt/homebrew/opt/spaceship/spaceship.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

#--------------------------#
# project simple
# -------------------------#

alias cls="clear" # 清理终端
alias ..="cd .." # 返回上一级
alias 。。="cd .." # 返回上一级
alias ...="cd ../.." # 返回上上级
alias 。。。="cd ../.." # 返回上上级
alias ....="cd ../../.." # 返回上上上级

# -------------------------------- #
# Alias
# -------------------------------- #
alias o="open"
alias c="code"
alias pip='pip3'
alias hugo="/opt/homebrew/bin/hugo"
alias cohu="cd ~/i/huyixi.com && ~/i/huyixi.com/utils/chu.sh"
alias gohu="cd ~/i/huyixi.com/"
alias ophu='cd /Applications && open -a "Github Desktop" && cd ~/Dev/huyixi.com/content/posts/ && open . && cd ~/Dev/huyixi.com/ '
alias hn="~/i/huyixi.com/utils/hugo-new.sh"
alias hs="~/i/huyixi.com/utils/hugo-server.sh"

#--------------------------#
# Reference
# -------------------------#

# antfu: https://github.com/antfu/dotfiles/blob/main/.zshrc
# Simon-He95: https://github.com/Simon-He95/awesome-collections/blob/bf5089729fe51251ba2338242ffdf587647caab3/zshrc/.zshrc#L164
