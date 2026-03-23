## Homebrew Packages Backup

This is the homebrew packages backup using `brew bundle`. 

You could back up current packages list before you install some packages,
Export current Homebrew packages into Brewfile:
```sh
brew bundle dump --file=~/.config/brew/Brewfile.txt
```

If you want to re-write the Brewfile.txt file, use `--force` (or `-f`) parameter:
```sh
brew bundle dump --force --file=~/.config/brew/Brewfile.txt
```

Install all the packages specified in the Brewfile:  
```sh
brew bundle install --file=~/.config/brew/Brewfile.txt
```

If you want to clean up the packages which are **not list** in the Brewfile (you can make the
**version control** combined with Git): 
```sh
brew bundle cleanup --file=~/.config/brew/Brewfile.txt
```

Finally, you need a final cleanup:  
```sh
brew autoremove
brew cleanup
```
