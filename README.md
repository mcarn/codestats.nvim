🥬 codestats.nvim
=================

Neovim plugin for [Code::Stats](https://codestats.net) using native HTTP API (no external dependencies).

## Features

- **Zero external dependencies**: Uses Neovim 0.12.0's native `vim.net.request()` API
- Compatible with [codestats-fish](https://github.com/nyaa8/codestats-fish) and [codestats-zsh](https://gitlab.com/code-stats/code-stats-zsh) (`CODESTATS_API_KEY`)
- Error handling with user notifications
- Health checks for configuration validation

## Requirements

- neovim 0.12.0 or newer (uses native `vim.net.request()` API)

## Installation

> **Note**: Tested with [Lazy](https://github.com/folke/lazy.nvim) and `vim.pack`. Other package managers may work but are untested.

### [Lazy](https://github.com/folke/lazy.nvim)

```lua
{
  "mcarn/codestats.nvim",
  config = function()
    require("codestats").setup({
      key = os.getenv("CODESTATS_API_KEY"),
      username = os.getenv("CODESTATS_USERNAME"),
    })
  end
}
```

### vim.pack

```bash
git clone https://github.com/mcarn/codestats.nvim ~/.config/nvim/pack/plugins/start/codestats.nvim
```

Then in your `init.lua`:
```lua
require("codestats").setup({
  key = os.getenv("CODESTATS_API_KEY"),
  username = os.getenv("CODESTATS_USERNAME"),
})
```

## Configuration

Set environment variables for your CodeStats credentials:

```bash
export CODESTATS_API_KEY="your-api-key"
export CODESTATS_USERNAME="your-username"
```

Alternatively, pass them directly to setup:

```lua
require("codestats").setup({
  key = "your-api-key",
  username = "your-username"
})
```

### Custom API URL

Set `CODESTATS_API_URL` to use a different Code::Stats instance:

```bash
export CODESTATS_API_URL="https://beta.codestats.net/api"
```

## Usage

### Commands

Use `:Codestats` to open a popup window exposing your api response information.

Run `:checkhealth codestats` to validate your setup.

### Lualine

Call `get_codestats` in any of the sections.

```lua
local function get_codestats()
  local codestats = require("codestats")
  local exp = codestats.current_xp()
  return "CS::" .. tostring(exp)
end
```

## Differences from Original

This is a complete rewrite of [nyaa8/codestats.nvim](https://github.com/nyaa8/codestats.nvim):

| Aspect | Original | This Version |
|--------|----------|--------------|
| **Language** | VimScript | Lua |
| **HTTP Client** | plenary.curl | vim.net.request (native) |
| **Dependencies** | plenary.nvim | None |
| **Neovim Version** | 0.5+ | 0.12.0+ |
| **Error Handling** | Basic | Comprehensive with notifications |
| **Health Checks** | None | Yes (`:checkhealth codestats`) |
| **Architecture** | Inline vimrc | Plugin structure |
