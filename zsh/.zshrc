export ZSH="$HOME/.oh-my-zsh"

plugins=(
  fzf-tab
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

export PATH="$PATH:$HOME/.rvm/bin"
export PATH="/opt/homebrew/lib/ruby/gems/3.3.0/bin:$PATH"
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export XDG_CONFIG_HOME="$HOME/.config"

zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':fzf-tab:*' continuous-trigger '/'
zstyle ':fzf-tab:complete:git-checkout:*' fzf-preview \
	'case "$group" in
	"modified file") git diff $word | delta ;;
	"recent commit object name") git show $word | delta ;;
	*) git ls --first-parent $word ;;
	esac'

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/ninuo/Developer/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/ninuo/Developer/google-cloud-sdk/path.zsh.inc'; fi

eval "$(zoxide init zsh)"

alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"
alias diff="pycharm diff"
alias ls="eza"
alias lst="ls -T -L 2"
alias ll="ls -abhlG --time-style=relative --git --group-directories-first --octal-permissions --no-user"
alias crc="code ~/.zshrc"
alias pi="pod install"
alias pu="pod update"
alias ir="iredis --rainbow --newbie --decode=utf8"
alias lz="lazygit"

eval "$(starship init zsh)"