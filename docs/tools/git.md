# Git

## Setup: Save Github credential

1. Go to Github.com -> Settings -> Developer settings -> Personal access tokens [https://github.com/settings/tokens](https://github.com/settings/tokens)
2. Generate a Personal Access Token (PAT) with the minimum required scopes are 'repo', 'read:org', 'workflow'
3. Copy the Personal Access Token
4. Go to the terminal and install the GitHub CLI
   - On Mac: `brew install gh`
   - On Archlinux: `sudo pacman -S github-cli`
5. In the terminal, enter `gh auth login`, then follow the prompts.
   - What account do you want to log into? **GitHub.com**
   - What is your preferred protocol for Git operations? **HTTPS**
   - Authenticate Git with your GitHub credentials? **Yes**
   - How would you like to authenticate GitHub CLI? **Paste an authentication token here**

> #### Old way (deprecated and unsecure)
> 1. Save in `~/.git-credentials` -> https://USER:PASS@github.com
> 2. Execute `git config --global credential.helper store `


## Undo local changes
```bash
git checkout .  # Revert modified files (in this . directory)
git clean -fd   # Remove new untracked files (-f) and new directories (-d): 
```