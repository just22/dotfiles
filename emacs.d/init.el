; ----------------------------------------------------------------------
;  $Id$
;
;  Emacs main configuration file
; ----------------------------------------------------------------------

; ----------------------------------------------------------------------
; General settings
;

; Set config dir
(add-to-list 'load-path "~/.emacs.d/init.d")

; Inhibit startup screen, toolbar, ...
(setq inhibit-startup-screen t)
(tool-bar-mode -1)
(menu-bar-mode -1)

; Set backup and autosave file locations
(defvar autosave-dir (expand-file-name "~/.emacs.d/autosave/"))
(setq auto-save-file-name-transforms `((".*" ,autosave-dir t)))
(defvar backup-dir (expand-file-name "~/.emacs.d/backup"))
(setq backup-directory-alist `((".*" . ,backup-dir)))

; ----------------------------------------------------------------------
; Packages
;
(when (not (require 'init-packages nil t))
        (message "Warning: config file `init-packages.el' not found")
        (view-echo-area-messages))

; ----------------------------------------------------------------------
; Styles
;
(when (not (require 'init-styles nil t))
        (message "Warning: config file `init-styles.el' not found")
        (view-echo-area-messages))

; ----------------------------------------------------------------------
; Modes
;
(when (not (require 'init-modes nil t))
        (message "Warning: config file `init-modes.el' not found")
        (view-echo-area-messages))

; ----------------------------------------------------------------------
; Keybinds
;
(when (not (require 'init-keybinds nil t))
        (message "Warning: config file `init-keybinds.el' not found")
        (view-echo-area-messages))

; ----------------------------------------------------------------------
; Custom functions
;
(when (not (require 'functions nil t))
        (message "Warning: config file `functions.el' not found")
        (view-echo-area-messages))

; ----------------------------------------------------------------------
; Other customization settings (automatically saved)
;
(setq custom-file "~/.emacs.d/custom-settings.el")
(load custom-file)
