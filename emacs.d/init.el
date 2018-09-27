; No startup screen, please!
(setq inhibit-startup-screen t)

; Set config dir
(add-to-list 'load-path "~/.emacs.d/config")

; Load config files
(when (not (require 'packages nil t))
        (message "Warning: config file `packages.el' not found")
        (view-echo-area-messages))
(when (not (require 'style nil t))
        (message "Warning: config file `style.el' not found")
        (view-echo-area-messages))
(when (not (require 'modes nil t))
        (message "Warning: config file `modes.el' not found")
        (view-echo-area-messages))
(when (not (require 'keybinds nil t))
        (message "Warning: config file `keybinds.el' not found")
        (view-echo-area-messages))
(when (not (require 'functions nil t))
        (message "Warning: config file `functions.el' not found")
        (view-echo-area-messages))

