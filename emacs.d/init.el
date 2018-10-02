;;;; --------------------------------------------------------------------
;;;;  $Id$
;;;;
;;;;  Emacs main configuration file
;;;; --------------------------------------------------------------------

;;;
;;; General settings
;;;

;; Set config dir
(add-to-list 'load-path "~/.emacs.d/init.d")

;; Inhibit startup screen, toolbar, ...
(setq inhibit-startup-screen t)
(tool-bar-mode -1)
(menu-bar-mode -1)

;; Set backup and autosave file locations
(defvar autosave-dir (expand-file-name "~/.emacs.d/autosave/"))
(setq auto-save-file-name-transforms `((".*" ,autosave-dir t)))
(defvar backup-dir (expand-file-name "~/.emacs.d/backup"))
(setq backup-directory-alist `((".*" . ,backup-dir)))

;; Show column number in mode line
(setq column-number-mode t)

;; Smooth scrolling (with offset)
(setq redisplay-dont-pause t
  scroll-margin 3
  scroll-step 1
  scroll-conservatively 10000
  scroll-preserve-screen-position 1)

;; Shortening for yes/no
(fset 'yes-or-no-p 'y-or-n-p)

;;;
;;; Packages
;;;
(when (not (require 'init-packages nil t))
        (message "Warning: config file `init-packages.el' not found")
        (view-echo-area-messages))

;;;
;;; Themes
;;;
(when (not (require 'init-themes nil t))
        (message "Warning: config file `init-themes.el' not found")
        (view-echo-area-messages))

;;;
;;; Modes
;;;
(when (not (require 'init-modes nil t))
        (message "Warning: config file `init-modes.el' not found")
        (view-echo-area-messages))

;;;
;;; Keybinds
;;;
(when (not (require 'init-keybinds nil t))
        (message "Warning: config file `init-keybinds.el' not found")
        (view-echo-area-messages))

;;;
;;; Custom functions
;;;
(when (not (require 'functions nil t))
        (message "Warning: config file `functions.el' not found")
        (view-echo-area-messages))

;;;
;;; Other customization settings (automatically saved)
;;;
(setq custom-file "~/.emacs.d/custom-settings.el")
(load custom-file)
