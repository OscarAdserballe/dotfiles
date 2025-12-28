dotfiles repo, to store all config-files for different programs.
For now,

- Neovim,
- tmux,
- iterm2

Basic idea: Migrate all files into dotfiles that can be version-controlled. Then, create a **symlink** to .config, so that when e.g. Neovim looks in .config it points to the file in dotfiles.

Instruction for creating new dotfile that's version-controlled:

`mkdir -p ~/dotfiles/.config/nvim`

(-p: parent, ensuring that it also creates intermediary folders that may not exist yet and doesn't throw error)

Moving file from .config:

`mv ~/.config/[...] ~/dotfiles/.config/`

Then create symlink:

`ln -s ~/dotfiles/.config/[...] ~/.config/[...]`

For Claude:

```
ln -sf ~/dotfiles/.config/claude/CLAUDE.md ~/.claude/CLAUDE.md
ln -sfh ~/dotfiles/.config/claude/agents ~/.claude/agents
ln -sfh ~/dotfiles/.config/claude/skills ~/.claude/skills
```
