dotfiles
========

doing the same tab color thing for gedit apparenty requires changing the entire Gnome theme: 
http://askubuntu.com/a/254071/326120

Not really a dotfile issue, but something to install on every computer used for coding:
```bash
sudo apt install fonts-firacode
```
How to activate: https://github.com/tonsky/FiraCode/wiki/Intellij-products-instructions

.bashrc things
==============

### Colored prompt with color for the command you type (really useful for reading your console!)

```bash
    PS1='\n\[\e[01;34m\]\w\[\e[00m\] \$ \[\e[1;35m\]'
    trap 'echo -ne "\e[0m"' DEBUG
```

How it works: `\e[01;34m` and similar change the color. The `trap` is needed to reset color after the user has hit enter and before the command is run.
Important: we need `\[   \]` around all control characters so bash can ignore them when counting the length of the prompt. Any mistakes with this will break prompt editing!

### Git-branch in prompt

Clone this repository as described there: https://github.com/jimeh/git-aware-prompt

Then use this as prompt:
```bash
    PS1="\n\[$bldblu\]\w\[$txtrst\] \[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\]\$ \[$bldpur\]"
    trap 'echo -ne "\e[0m"' DEBUG
```

### View Spark-Log in a separate terminal (keeps your CLI window clean!):
```bash
    function sparkshell() {
      gnome-terminal -e "tail -f $HOME/spark.log"
      ~/opt/spark-1.5.1-bin-hadoop2.6/bin/spark-shell
    }
```

# minimize on click using launcher / dock (just like MS Windows task bar...)

1. Install "Unity Tweak Tool" using the "Software" application.
2. Find the setting in the Tweak Tool under the "Launcher" group.

Alternative Way (also restores the "click show window" instead of the thumbnails):
```bash
    gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize'
```
