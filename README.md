dotfiles repo, to store all config-files for different programs.

`mkdir -p ~/dotfiles/.config/nvim`

Moving file from .config:

`mv ~/.config/[...] ~/dotfiles/.config/`

Symlink:

`ln -s ~/dotfiles/.config/[...] ~/.config/[...]`

Claude:

```
ln -sf ~/dotfiles/.config/claude/CLAUDE.md ~/.claude/CLAUDE.md
ln -sfh ~/dotfiles/.config/claude/agents ~/.claude/agents
ln -sfh ~/dotfiles/.config/claude/skills ~/.claude/skills
```
