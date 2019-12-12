# ZSH Setup file
# ==============

# Common PATHS
# ------------
export ZSH=$HOME/.oh-my-zsh

# OS Specific PATHS
# -----------------
if [[ "$OSTYPE" == "linux-gnu" ]]; then
   # === GRASP
   GRASP="$USER/bin/grasp/bin"
   GRASPTOOLS="$USER/bin/grasptools"
   # === Export main PATH
   PATH="$GRASP:$GRASPTOOLS:$PATH"

   # GPG
   export GPG_TTY=$(tty)

elif [[ "$OSTYPE" == "darwin"* ]]; then
   # === General
   JULIA="/Applications/Julia-1.2.app/Contents/Resources/julia/bin/"
   GENCLnew="$HOME/Codes/apps/gencl/bin"
   ATSPbook="$GENCLnew:$HOME/Codes/apps/atsp_bookcodes/bin"
   GRASP="$HOME/Codes/apps/grasp/bin"
   GRASPTOOLS="$HOME/Codes/apps/grasptools"
   DUO="$HOME/Codes/apps/Duo"
   X2DHF="$HOME/Codes/apps/x2dhf/bin"
   XUVTOP="$HOME/Codes/apps/chianti/dbase"
   SPHF="$HOME/Codes/apps/SPHF/src/bin"
   WIGXJPF="$HOME/Codes/libs/wigxjpf-1.9/bin"
   ANACONDA="$HOME/anaconda3/bin"
   # === plusfort / spag
   PFDIR=/opt/plusfort_MacOS_725
   export PFDIR
   # === SUMO
   export SUMO_DIR="$HOME/Codes/apps/SUMO"
   source $SUMO_DIR/sumo_compilervars.sh gfortran
   # === Export main PATH
   export PATH=$PFDIR:$JULIA:$ATSPbook:$SPHF:$SUMO_DIR:$WIGXJPF:$X2DHF:$DUO:$GRASP:$ANACONDA:$GRASPTOOLS:$HOME/Codes/bin:/usr/local/bin:/opt/local/bin:/opt/local/sbin:$HOME/.local/bin:/Users/jon/Library/Python/3.7/bin:$PATH
   # === Python (Anaconda)
   export PYTHONPATH=$WIGXJPF/pywigxjpf:$ANACONDA/python:$HOME/Library/Python/3.7/bin:$PYTHONPATH
   # === Intel Compiler Env. Vars
   source /opt/intel/bin/compilervars.sh -arch intel64 -platform mac
   source /opt/intel/compilers_and_libraries_2018.3.185/mac/mkl/bin/mklvars.sh intel64
   # === IDL
   source /Applications/exelis/idl85/bin/idl_setup.bash
   export IDL_PATH="+.:+/Applications/exelis/idl85" #:/Users/jon/Codes/libs/anglib_idl"
   # === GCC - make Mac OS use Brew's GNU compilers instead of native
   export CC=/usr/local/bin/gcc-9
   export CXX=/usr/local/bin/gcc-9
   export CPP=/usr/local/bin/cpp-9
   export LD=/usr/local/bin/gcc-9
   alias gcc='gcc-9'
   alias cc='gcc-9'
   alias g++='g++-9'
   alias c++='c++-9'
   alias cpp='cpp-9'
   alias ld='gcc-9'
   # === Manuals (Mac OS trick)
   export MANPATH=/opt/local/share/man:$MANPATH
fi


# Itermplot
# ---------
#export MPLBACKEND="module://itermplot" # Export for terminal plotting (https://github.com/daleroberts/itermplot)
#export ITERMPLOT=rv                    # Reverse video setting for dark background (itermplot) plots

# General ZSH settings
# --------------------
ZSH_THEME="gruvbox"       # main zsh theme [github.com/robbyrussell/oh-my-zsh/wiki/Themes]
SOLARIZED_THEME="dark"    # dark/light
CASE_SENSITIVE="true"     # case-sensitive completion.
HIST_STAMPS="yyyy-mm-dd"  # Time formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
#COMPLETION_WAITING_DOTS="true" # display red dots whilst waiting for completion.


# ZSH Plugins
# -----------
# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.

if [[ "$OSTYPE" == "linux-gnu" ]]; then
   # === GNU/Linux
   plugins=(
   git
   colored-man-pages
   extract
   zsh-syntax-highlighting
   )
   source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
elif [[ "$OSTYPE" == "darwin"* ]]; then
   # === Mac OS
   plugins=(
   osx
   git
   colored-man-pages
   extract
   zsh-syntax-highlighting
   )
   source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi
source $ZSH/oh-my-zsh.sh


# Default editor
# --------------
if [[ -n $SSH_CONNECTION ]]; then
   # For local sessions
   # === Editor
   export EDITOR='nvim'
else
   # for remote sessions
   # === Editor
   export EDITOR='nvim'    # nvim
   # === No hangups (nohup + disown     )
   setopt NO_HUP
   setopt NO_CHECK_JOBS
fi

# SSH
# ---
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Aliases
# -------
# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

if type nvim > /dev/null 2>&1; then
   alias vim='nvim'
   alias vi='nvim'
fi

alias diff="colordiff"   # use colored diff's
alias python=python3     # make sure python points to python3

# GITHOME - dotfile tracking
# --------------------------
# Alias for git command specialized to track files of choice (dot-files) in $HOME
# Make sure:
# 1) git init --bare $HOME/.cfg
# 2) alias githome='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
# 3) githome config --local status.showUntrackedFiles no
alias githome='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# Additional ZSH setup
# ====================
# autocompletion fix for .. to result in ../<suggestions> while tabbing
zstyle ':completion:*' special-dirs true

# Prompt setup [see man zshmisc --> SIMPLE PROMPT ESCAPES]
DEFAULT_USER='jon'
prompt_context() {
   if [[ "$USER" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
      prompt_segment black default "%(!.%{%F{yellow}%}.)$USER"
   fi
}
