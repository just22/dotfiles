;;;; --------------------------------------------------------------------
;;;;  $Id$
;;;;
;;;;  Emacs themes configuration file
;;;; --------------------------------------------------------------------

(provide 'init-themes)

;;;
;;; Base16
;;;
(use-package base16-theme
  :ensure t
  :config
  (load-theme 'base16-solarized-dark t))
