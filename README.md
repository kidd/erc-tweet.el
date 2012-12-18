# erc-tweet.el #

Show inlined tweets (png/jpg) in erc buffers.

usage:

```lisp
(require 'erc-tweet)
(add-to-list 'erc-modules 'tweet)
(erc-update-modules)
```

Or `(require 'erc-tweet)` and  `M-x customize-option erc-modules RET`

This plugin subscribes to hooks `erc-insert-modify-hook` and
`erc-send-modify-hook` to download and show tweets.