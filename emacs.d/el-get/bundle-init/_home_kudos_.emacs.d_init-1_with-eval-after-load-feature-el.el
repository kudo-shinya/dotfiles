(require 'init-loader)
(setq init-loader-show-log-after-init nil)
(init-loader-load "~/.emacs.d/inits")
(if
    (not
     (equal
      (init-loader-error-log)
      ""))
    (init-loader-show-log))
