# FetchSSHKey

Get SSH public key from our public repository on <https://keys.makandra.de> and
paste it into vim.

# Installation

Use e.g. `vim-plug`: `Plug 'eheinle-mak/fetchsshkey'`

Or just clone it to your plugin directory: `git clone https://github.com/eheinle-mak/fetchsshkey.git ~/.vim/plugin/fetchsshkey`.

# Usage

```vim
:FetchSSHKey emma.heinle
```

This will retrieve <https://keys.makandra.de/ssh/emma.heinle.pub> and return _just the key material_, without the `ssh-rsa` (1st field) part and without the comment (3rd field). At this point in time, determining the ssh key type is left to the user.

# License

Public domain
