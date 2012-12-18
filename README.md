# erc-twitt.el #

Show inlined twitts (png/jpg) in erc buffers.

usage:

```lisp
(require 'erc-twitt)
(add-to-list 'erc-modules 'twitt)
(erc-update-modules)
```

Or `(require 'erc-twitt)` and  `M-x customize-option erc-modules RET`

This plugin subscribes to hooks `erc-insert-modify-hook` and
`erc-send-modify-hook` to download and show twitts.