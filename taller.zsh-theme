###################
# BUILDING PROMPT #
###################

# username --> %n
# machine name --> %m
# current location --> %~
# \uE0A0 

# Main prompt (left)
PROMPT='$fg[white]╭───── 📁  $(get_pwd)%b $fg[white]
$(git_prompt_info)%{$reset_color%}$(git_prompt_status)$fg[white] $(_git_time_since_commit)$fg[white]
├─ $(nvm_prompt_info)
│
╰$_SYMBOL'

# Main prompt (right)
RPROMPT=''

# ➭ ✔ ✈ ✭ ✗ ➦ ✂ ✱
# Prompt symbols
# _SYMBOL="%{$fg[red]%}➭ %{$fg[yellow]%}➭ %{$fg[cyan]%}➭ "
_SYMBOL=">"



######################
# Git Prompt Builder #
######################

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[white]%}├───  "
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
# ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}✗%{$reset_color%} "
# ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[white]%}◒ "
# ZSH_THEME_GIT_PROMPT_CLEAN=" "
ZSH_THEME_GIT_PROMPT_DIRTY=" "
ZSH_THEME_GIT_PROMPT_UNTRACKED=" "
ZSH_THEME_GIT_PROMPT_CLEAN=" "
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[red]%}✓ "
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[red]%}△ "
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%}✖ "
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[red]%}➜ "
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[red]%}§ "
ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg[yellow]%}▲ "

ZSH_THEME_GIT_TIME_SINCE_COMMIT_SHORT="%{$fg[white]%}"
ZSH_THEME_GIT_TIME_SHORT_COMMIT_MEDIUM="%{$fg[yellow]%}"
ZSH_THEME_GIT_TIME_SINCE_COMMIT_LONG="%{$fg[red]%}"
ZSH_THEME_GIT_TIME_SINCE_COMMIT_NEUTRAL="%{$fg[white]%}"


#
# Determine the time since last commit. If branch is clean,
# use a neutral color, otherwise colors will vary according to time.
function _git_time_since_commit() {
# Only proceed if there is actually a commit.
  if git log -1 > /dev/null 2>&1; then
    # Get the last commit.
    last_commit=$(git log --pretty=format:'%at' -1 2> /dev/null)
    now=$(date +%s)
    seconds_since_last_commit=$((now-last_commit))

    # Totals
    minutes=$((seconds_since_last_commit / 60))
    hours=$((seconds_since_last_commit/3600))

    # Sub-hours and sub-minutes
    days=$((seconds_since_last_commit / 86400))
    sub_hours=$((hours % 24))
    sub_minutes=$((minutes % 60))

    if [ $hours -gt 24 ]; then
      commit_age="${days}d "
    elif [ $minutes -gt 60 ]; then
      commit_age="${sub_hours}h${sub_minutes}m "
    else
      commit_age="${minutes}m "
    fi
    if [[ -n $(git status -s 2> /dev/null) ]]; then
        if [ "$hours" -gt 4 ]; then
            COLOR="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_LONG"
        elif [ "$minutes" -gt 30 ]; then
            COLOR="$ZSH_THEME_GIT_TIME_SHORT_COMMIT_MEDIUM"
        else
            COLOR="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_SHORT"
        fi
    else
        COLOR="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_NEUTRAL"
    fi


    echo "$COLOR$commit_age%{$reset_color%}"
  fi
}


######################
# NVM Prompt Builder #
######################

ZSH_THEME_NVM_PROMPT_PREFIX="%{$fg[green]%}⬢ %{$fg[white]%}"
# ZSH_THEME_NVM_PROMPT_SUFFIX="%{$fg[white]%}"


########################
# Location Path Setter #
########################

function get_pwd(){
  git_root=$PWD
  while [[ $git_root != / && ! -e $git_root/.git ]]; do
    git_root=$git_root:h
  done
  if [[ $git_root = / ]]; then
    unset git_root
    prompt_short_dir=%~
  else
    parent=${git_root%\/*}
    prompt_short_dir=${PWD#$parent/}
  fi
  echo $prompt_short_dir
}