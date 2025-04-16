export PYENV_ROOT="$HOME/.pyenv"

# If you come from bash you might have to change your $PATH.
if ! [[ "$PATH" =~ "$HOME/.cargo/bin:$HOME/.local/go/bin:$HOME/go/bin:$PYENV_ROOT/bin:$HOME/.local/bin:" ]]; then
  PATH="$HOME/.cargo/bin:$HOME/.local/go/bin:$HOME/go/bin:$PYENV_ROOT/bin:$HOME/.local/bin:$PATH"
fi
export PATH

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# pyenv
eval "$(pyenv init - zsh)"

# ssh-agent
if ! pgrep -u "$USER" ssh-agent >/dev/null; then
  ssh-agent -t 48h >"$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [[ ! -f "$SSH_AUTH_SOCK" ]]; then
  source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
fi
