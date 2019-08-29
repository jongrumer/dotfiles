# -- Personal settings --


# Paths
# =====
# Main
ANACONDA="$HOME/anaconda3/bin"
GRASP="$HOME/Codes/apps/grasp/bin"
GRASPTOOLS="$HOME/Codes/apps/grasptools"
DUO="$HOME/Codes/apps/Duo"
X2DHF="$HOME/Codes/apps/x2dhf/bin"
WIGXJPF="$HOME/Codes/libs/wigxjpf-1.9/bin"
XUVTOP="$HOME/Codes/apps/chianti/dbase"
export SUMO_DIR="$HOME/Codes/apps/SUMO"

# Export main PATH
export PATH=$SUMO_DIR:$WIGXJPF:$X2DHF:$DUO:$GRASP:$ANACONDA:$GRASPTOOLS:$HOME/Codes/bin:/usr/local/bin:/opt/local/bin:/opt/local/sbin:$HOME/.local/bin:$PATH

# Python
export PYTHONPATH=$WIGXJPF/pywigxjpf:$ANACONDA/python:$PYTHONPATH

# Manual
export MANPATH=/opt/local/share/man:$MANPATH

# Compiler Env. Vars
# ==================
# Intel MKL
source /opt/intel/bin/compilervars.sh -arch intel64 -platform mac
source /opt/intel/compilers_and_libraries_2018.3.185/mac/mkl/bin/mklvars.sh intel64

# SUMO
source $SUMO_DIR/sumo_compilervars.sh gfortran

# Oh-my-zsh PATH
# ===========================
export ZSH=/Users/jon/.oh-my-zsh

# IDL setup and path
# ==================
source /Applications/exelis/idl85/bin/idl_setup.bash
export IDL_PATH="+.:+/Applications/exelis/idl85"
#:/Users/jon/Codes/libs/anglib_idl"

# Misc
# ====
# - itermplot: for terminal plotting (https://github.com/daleroberts/itermplot)
export MPLBACKEND="module://itermplot"
export ITERMPLOT=rv # Reverse video setting for dark background (itermplot) plots

# - DYnamic Library PATH - note that this could mess things up, so be careful
# export DYLD_LIBRARY_PATH="/usr/lib:/usr/local/lib:/Users/jon/anaconda3/lib"

# ===== General ZSH settings ======
#
# Powerline status bar plugin
# ===========================
# source /Users/jon/.vim/bundle/powerline/powerline/bindings/zsh/powerline.zsh

# Theme
# =====
# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="powerlevel9k/powerlevel9k"
# ZSH_THEME="steeef"
ZSH_THEME="agnoster"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  osx
  git
  colored-man-pages
  extract
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias diff="colordiff"

if type nvim > /dev/null 2>&1; then
  alias vim='nvim'
  alias vi='nvim'
fi

# Make mac use GNU compilers installed with Brew - e.g. to support openmp
export CC=/usr/local/bin/gcc-8
export CXX=/usr/local/bin/gcc-8
export CPP=/usr/local/bin/cpp-8
export LD=/usr/local/bin/gcc-8

alias gcc='gcc-8'
alias cc='gcc-8'
alias g++='g++-8'
alias c++='c++-8'
alias cpp='cpp-8'
alias ld='gcc-8'

# Alias for git command specialized to track files of choice (dot-files) in $HOME
   # Make sure:
   # 1) git init --bare $HOME/.cfg
   # 2) alias githome='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
   # 3) githome config --local status.showUntrackedFiles no
alias githome='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# autcompletion fix for .. to result in ../<suggestions> while tabbing
zstyle ':completion:*' special-dirs true

# Prompt setup [see man zshmisc --> SIMPLE PROMPT ESCAPES]
DEFAULT_USER='jon'
prompt_context() {
  if [[ "$USER" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
    prompt_segment black default "%(!.%{%F{yellow}%}.)$USER"
  fi
}

# ZSH syntax highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
