Repo with configuration (dot-files) files for Linux/MacOS.

To avoid symlinking it's advantageous to use the bare repository strategy (from [[1]](https://www.atlassian.com/git/tutorials/dotfiles)):

In `$HOME`, run
```bash
git init --bare $HOME/.cfg
alias githome='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
githome config --local status.showUntrackedFiles no
```
where
1. The first line creates a folder ~/.cfg which is a Git bare repository that will track our files.
2. Create an alias `githome` (replace this name with whatever you prefer) which is used instead of the regular `git` command when we want to interact with our configuration repository.
3. Set a flag - local to the repository - to hide files we are not explicitly tracking yet. This is so that when you type `githome` status and other commands later, files you are not interested in tracking will not show up as untracked.

Preferably you add the alias to your .zsh or .bashrc.

New files to be tracked are then just added as normal, you just wont have them lying at the same place as your `.git` tracking files.

```bash
githome status
githome add .bashrc
githome commit -m "Add .bashrc"
githome add .config/nvim/init.vim
githome commit -m "Add NeoVim config file"
githome push
```

[1] https://www.atlassian.com/git/tutorials/dotfiles
