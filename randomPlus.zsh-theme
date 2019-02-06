###################
# BUILDING PROMPT #
###################

  # Main prompt (left)
  PROMPT='$(check_git_prompt_info)$(nvm_prompt_info) | $fg[cyan]%n $fg[white]on $fg[blue]%m $fg[white]in $fg[magenta]%~%b
  $(random_emoji) $_SYMBOL'

  # Main prompt (right)
  RPROMPT=''

##################
# GATHERING BITS #
##################

  # Get more options here: http://getemoji.com/
  EMOJI=(👽 💀 🐦 🐷 🐻 🐼 🐨 🐯 🦁 🐮 🐶 🐸 🐧 🐳 🐌 🐓 🐢 🐍 🦄 🐙 🐠 🐘 🌍 🍄 🌻 👻 ⛄️ 🍭 🍌 🍍 ⛱ 📓 📚 📖 🎈 🖌 🖍 ✏️ 🎨 💬 💭 🗯 💩 🚀 ⛵️ 😎 😜 😝)
  function random_emoji {
    echo -n "$EMOJI[$RANDOM%$#EMOJI+1] "
  }

  # Prompt symbols
  _SYMBOL="%{$fg[red]%}>%{$fg[yellow]%}>%{$fg[cyan]%}> "



######################
# Git Prompt Builder #
######################

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} | "

# Text to display if the branch is dirty
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}*"

# Text to display if the branch is clean
ZSH_THEME_GIT_PROMPT_CLEAN=""


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

ZSH_THEME_NVM_PROMPT_PREFIX="%{$fg[green]%}⬡ "
ZSH_THEME_NVM_PROMPT_SUFFIX="%{$fg[white]%}"ami