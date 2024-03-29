;;;  _____                                 _         _  _       __  _  _       
;;; | ____| _ __ ___    __ _   ___  ___   (_) _ __  (_)| |_    / _|(_)| |  ___ 
;;; |  _|  | '_ ` _ \  / _` | / __|/ __|  | || '_ \ | || __|  | |_ | || | / _ \
;;; | |___ | | | | | || (_| || (__ \__ \  | || | | || || |_   |  _|| || ||  __/
;;; |_____||_| |_| |_| \__,_| \___||___/  |_||_| |_||_| \__|  |_|  |_||_| \___|
;;;                                                                           



;;; ---------------------------------------------------------------------
;;; General settings
;;; ---------------------------------------------------------------------

;; User's directory
(setq user-emacs-directory (expand-file-name "~/.emacs.d/"))

;; Local pre-init file (optional)
(setq init-local-pre
      (expand-file-name "init-local-pre.el" user-emacs-directory))
(if (file-exists-p init-local-pre)
    (load init-local-pre))

;; Options saved from menu bar
(setq custom-file
      (expand-file-name "saved-options.el" user-emacs-directory))
(if (file-exists-p custom-file)
    (load custom-file))

;; Set backup and autosave file locations
(defvar autosave-dir
  (expand-file-name "autosave/" user-emacs-directory))
(setq auto-save-file-name-transforms `((".*" ,autosave-dir t)))

(defvar backup-dir
  (expand-file-name "backup/" user-emacs-directory))
(setq backup-directory-alist `((".*" . ,backup-dir)))

(unless (file-exists-p autosave-dir)
  (make-directory autosave-dir))

(unless (file-exists-p backup-dir)
  (make-directory backup-dir))

;; Minimal user interface
(setq inhibit-startup-message t)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)

(unless (eq system-type 'darwin)
  (menu-bar-mode -1)
  (setq visual-bell t))

;; Show column number in mode line
(setq column-number-mode t)

;; Show line numbers
(global-display-line-numbers-mode t)
(dolist (mode '(term-mode-hook
		org-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; Highlight cursor line
(global-hl-line-mode t)
(dolist (mode '(term-mode-hook))
  (add-hook mode (lambda () (setq-local global-hl-line-mode nil))))

;; Smooth scrolling (with offset)
(setq redisplay-dont-pause t)
(setq scroll-margin 3)
(setq scroll-step 1)
(setq scroll-conservatively 10000)
(setq scroll-preserve-screen-position t)

;; Shortening for yes/no
(fset 'yes-or-no-p 'y-or-n-p)

;; By default, (visually) truncate long lines (i.e., do not wrap them)
(set-default 'truncate-lines t)

;; Always follow symbolic links to files under version control
(setq vc-follow-symlinks t)


;;; ---------------------------------------------------------------------
;;; Package management
;;; ---------------------------------------------------------------------

;; Initialize package sources
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("org"   . "https://orgmode.org/elpa/"))
(add-to-list 'package-archives '("elpa"  . "https://elpa.gnu.org/packages/"))

(setq package-enable-at-startup nil)
(package-initialize)

;; Install and initialize package manager (use-package)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)


;;; ---------------------------------------------------------------------
;;; Themes
;;; ---------------------------------------------------------------------
(use-package solarized-theme
  :init
  (load-theme 'solarized-dark t))


;;; ---------------------------------------------------------------------
;;; Packages
;;; ---------------------------------------------------------------------

;; undo-fu - Simple, stable linear undo with redo
(use-package undo-fu)

;; undo-fu-session - Save & recover undo steps between sessions
(use-package undo-fu-session)
(undo-fu-session-global-mode)


;; Evil - Extensible Vi Layer
(use-package evil
  :init
  (setq evil-undo-system 'undo-fu)
  (setq evil-split-window-below t)
  (setq evil-vsplit-window-right t)
  (setq evil-auto-balance-windows t)

  :config
  (evil-mode t)

  (evil-define-command evil-cust-edit (file &optional bang)
    "Open FILE.
If no FILE is specified, reload the current buffer from disk."
    :repeat nil
    (interactive "<f><!>")
    (if file
      (find-file file)
      (progn
        (revert-buffer bang (or bang (not (buffer-modified-p))) t)
        (read-only-mode -1))))
  (evil-ex-define-cmd "e[dit]" 'evil-cust-edit)

  (evil-define-command evil-cust-view (file &optional bang)
    "Open FILE in read-only mode.
If no FILE is specified, reload the current buffer from disk."
    :repeat nil
    (interactive "<f><!>")
    (if file
      (find-file-read-only file)
      (progn
        (revert-buffer bang (or bang (not (buffer-modified-p))) t)
        (read-only-mode))))

  (evil-ex-define-cmd "v[iew]" 'evil-cust-view))

(with-eval-after-load 'evil
  (define-key evil-normal-state-map (kbd "C-w h")   'evil-window-vsplit)
  (define-key evil-normal-state-map (kbd "C-w C-h") 'evil-window-vsplit)
  (define-key evil-normal-state-map (kbd "C-w v")   'evil-window-split)
  (define-key evil-normal-state-map (kbd "C-w C-v") 'evil-window-split))


;; helm - Framework for incremental completions and narrowing selections
(use-package helm
  :config
  (helm-autoresize-mode 1)
  
  :bind (("M-x" . helm-M-x)
	 ("C-x C-b" . helm-mini)
	 ("C-x C-f" . helm-find-files)))

(custom-set-faces
 '(helm-selection ((t (:underline nil)))))


;;; ---------------------------------------------------------------------
;;; Modes
;;; ---------------------------------------------------------------------

;; In terminal, use same prefix (C-x) as other modes
(add-hook 'term-mode-hook
   (lambda ()
     (term-set-escape-char ?\C-x)
     (define-key term-raw-map "\M-y" 'yank-pop)
     (define-key term-raw-map "\M-w" 'kill-ring-save)))

;;; ---------------------------------------------------------------------
;;; Keybinds
;;; ---------------------------------------------------------------------

;; Keybinds/shortcuts specific for MacOS
(if (eq system-type 'darwin)
    (progn
      (setq mac-option-key-is-meta nil)
      (setq mac-option-modifier 'super)
      (setq mac-right-option-modifier 'none)
      (setq mac-command-key-is-meta t)
      (setq mac-command-modifier 'meta)
      (global-set-key (kbd "M-s-m") 'toggle-frame-maximized)
      (global-set-key (kbd "M-s-f") 'toggle-frame-fullscreen)
      (global-set-key (kbd "M-s--") 'suspend-frame)))

;; Copy/paste from/to system clipboard
(global-set-key (kbd "C-c C-x") 'clipboard-kill-region)
(global-set-key (kbd "C-c C-c") 'clipboard-kill-ring-save)
(global-set-key (kbd "C-c C-v") 'clipboard-yank)

;; Use Esc to abort commands and quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)


;;; ---------------------------------------------------------------------
;;; Custom functions
;;; ---------------------------------------------------------------------

;; Change the frame font size
(defun change-font-size (delta)
  (set-face-attribute 'default
		      (selected-frame)
		      :height (+ (face-attribute 'default :height) delta)))
(global-set-key (kbd "C-+")
		'(lambda () (interactive) (change-font-size +10)))
(global-set-key (kbd "C--")
		'(lambda () (interactive) (change-font-size -10)))

;; Launch ansi-term with tmux
(defun tmux ()
  (interactive)
  (term "tmux"))


;;; ---------------------------------------------------------------------
;;; Local post-init file (optional)
;;; ---------------------------------------------------------------------
(setq init-local-post
      (expand-file-name "init-local-post.el" user-emacs-directory))
(if (file-exists-p init-local-post)
    (load init-local-post))
