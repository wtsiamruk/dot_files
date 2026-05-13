
# 1. Define paths and flags
OH_MY_ZSH_DIR="$HOME/.oh-my-zsh"
SDKMAN_DIR="$HOME/.sdkman"
NVM_DIR="$HOME/.nvm"
MISSING_TOOLS=0

# 2. Check for Oh My Zsh (Directory)
if [ ! -d "$OH_MY_ZSH_DIR" ]; then
    echo "Warning: Oh My Zsh is not installed (checked $OH_MY_ZSH_DIR)." >&2
    MISSING_TOOLS=1
fi

# 3. Check for SDKMAN (Directory)
if [ ! -d "$SDKMAN_DIR" ]; then
    echo "Warning: SDKMAN is not installed (checked $SDKMAN_DIR)." >&2
    MISSING_TOOLS=1
fi

# 4. Check for Neovim (Executable)
if ! command -v nvim >/dev/null 2>&1; then
    echo "Warning: Neovim (nvim) is not installed or not in your PATH." >&2
else
    export EDITOR=nvim
fi

# 5. Final validation and proceeding
if [ "$MISSING_TOOLS" -eq 1 ]; then
    echo "Aborting full zshrc configuration due to missing dependencies." >&2
else
# the config block start
    # debug line config start block
    # echo "All dependencies found. Proceeding with configuration."
    
    # If you come from bash you might have to change your $PATH.
    export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

    # Path to your Oh My Zsh installation.
    export ZSH="$OH_MY_ZSH_DIR"

    # Gets the directory where this specific file (or its symlink target) lives
    export ZSH_CUSTOM="${${(%):-%x}:A:h}/oh-my-zsh-custom"
    
    ZSH_THEME="jonathan"
    DISABLE_AUTO_TITLE="true"
    plugins=(git docker)
    source $ZSH/oh-my-zsh.sh

    # default configs for nvm and sdkman

    #THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
    export SDKMAN_DIR="$HOME/.sdkman"
    [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
    export PATH="$HOME/.local/bin:$PATH"

    # default configs for nvm and sdkman

    # custom envs set
    ENV_DIR="$HOME/.env/"
    if [ -d "$ENV_DIR" ]; then
      for env_file in "$ENV_DIR"/*.sh; do
        if [ -f "$env_file" ]; then
          source "$env_file"
        fi
      done
    else
      echo "WARNING: envs config dir $ENV_DIR not found, cusom envs aren't set"
    fi

    
    # Override cursor shape when running in Kitty terminal
    if [[ "$TERM" == "xterm-kitty" ]]; then
        echo -ne '\e[2 q'
    fi

# the config block - end
fi

