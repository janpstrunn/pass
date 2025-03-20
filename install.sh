#!/usr/bin/env bash

echo "Cloning repository"
git clone https://github.com/janpstrunn/pass
cd pass

# Install the main script
chmod 700 src/pass
mv src/pass "$HOME/.local/bin/" && echo "Moved script to $HOME/.local/bin/"

# Install man pages
mkdir -p "$HOME/.local/share/man/man1"
cp docs/pass.1 "$HOME/.local/share/man/man1/" && echo "Created manpage file at $HOME/.local/share/man/man1/"
mandb "$HOME/.local/share/man/" 2>/dev/null || true

if [ "$SHELL" == "bash" ]; then
  # Install Bash autocompletion
  mkdir -p "$HOME/.local/share/bash-completion/completions"
  cp share/_pass.bash "$HOME/.local/share/bash-completion/completions/pass" && echo "Generated a bash autocompletion at $HOME/.local/share/bash-completion/completions/"
elif [ "$SHELL" == "zsh" ]; then
  # Install Zsh autocompletion
  mkdir -p "$HOME/.local/share/zsh/site-functions"
  cp share/_pass "$HOME/.local/share/zsh/site-functions/" && echo "Generated a zsh autocompletion at $HOME/.local/share/zsh/site-functions/"
fi

echo "Installation complete. Restart your shell or run 'exec bash'/'exec zsh' to apply changes."
