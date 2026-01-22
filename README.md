dotfiles repo, to store all config-files for different programs.

## Quick Setup

Run all commands to symlink everything:

```bash
# Claude
ln -sf ~/dotfiles/.config/claude/CLAUDE.md ~/.claude/CLAUDE.md
ln -sfh ~/dotfiles/.config/claude/agents ~/.claude/agents
ln -sfh ~/dotfiles/.config/claude/skills ~/.claude/skills

# Codex (shares CLAUDE.md as AGENTS.md)
ln -sf ~/dotfiles/.config/claude/CLAUDE.md ~/.codex/AGENTS.md

# Neovim
ln -sfh ~/dotfiles/.config/nvim ~/.config/nvim

# Tmux
mkdir -p ~/.config/tmux
ln -sf ~/dotfiles/.config/tmux/tmux.conf ~/.config/tmux/tmux.conf

# Zsh
ln -sf ~/dotfiles/.config/zsh/.zshrc ~/.zshrc

# Opencode
ln -s ~/dotfiles/.config/opencode/opencode.jsonc ~/.config/opencode/opencode.jsonc
```
