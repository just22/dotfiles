;;;; --------------------------------------------------------------------
;;;;  $Id$
;;;;
;;;;  Emacs packages configuration file
;;;; --------------------------------------------------------------------

(provide 'init-packages)

;;;
;;; (Optional) proxy settings
;;;
(when (not (require 'init-proxy nil t))
        (message "Info: no proxy config file found, skipping."))

;;;
;;; Default Emacs package manager
;;;
(require 'package)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

(setq package-enable-at-startup nil)
(package-initialize)

;;;
;;; use-package macro
;;;
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))
