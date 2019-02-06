###################
# BUILDING PROMPT #
###################

# username --> %n
# machine name --> %m
# current location --> %~

# Main prompt (left)
PROMPT='$fg[yellow]   _     
__(.)$fg[red]<$fg[white]  ╭─$(nvm_prompt_info) $fg[yellow]$(get_pwd)%b$(check_git_prompt_info) 
$fg[yellow]\___)$fg[white]   ╰───>> '

RPROMPT=''

######################
# Git Prompt Builder #
######################

ZSH_THEME_GIT_PROMPT_PREFIX="-["
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg[white]%}]"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[red]%} ✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%} ✔"



# Git sometimes goes into a detached head state. git_prompt_info doesn't
# return anything in this case. So wrap it in another function and check
# for an empty string.
function check_git_prompt_info() {
    if git rev-parse --git-dir > /dev/null 2>&1; then
        if [[ -z $(git_prompt_info) ]]; then
            echo "%{$fg[magenta]%}detached-head%{$reset_color%})"
        else
            echo "$(git_prompt_info)"
        fi
    fi
}


######################
# NVM Prompt Builder #
######################

ZSH_THEME_NVM_PROMPT_PREFIX="%{$fg[green]%}⬡ %{$fg[white]%}"
ZSH_THEME_NVM_PROMPT_SUFFIX="%{$fg[white]%}"


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