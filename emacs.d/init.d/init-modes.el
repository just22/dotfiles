;;;; --------------------------------------------------------------------
;;;;  $Id$
;;;;
;;;;  Emacs modes configuration file
;;;; --------------------------------------------------------------------

(provide 'init-modes)

;;;
;;; If `display-line-numbers-mode' is available (only in Emacs 26),
;;; use it! Otherwise, install and run nlinum-mode.
;;;
(if (functionp 'display-line-numbers-mode)
  (add-hook 'prog-mode-hook 'display-line-numbers-mode)
  (use-package nlinum
    :ensure t
    :config
    (add-hook 'prog-mode-hook 'linum-mode)))

;;;
;;; Evil
;;;
(use-package evil
  :ensure t
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
