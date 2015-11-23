dotfiles
========

doing the same tab color thing for gedit apparenty requires changing the entire Gnome theme: 
http://askubuntu.com/a/254071/326120

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

https://github.com/jimeh/git-aware-prompt

### View Spark-Log in a separate terminal (keeps your CLI window clean!):
```bash
    function sparkshell() {
      gnome-terminal -e "tail -f $HOME/spark.log"
      ~/opt/spark-1.5.1-bin-hadoop2.6/bin/spark-shell
    }
```
