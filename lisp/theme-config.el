(provide 'theme-config)

;; Gruvbox for change of pace every now and then.
;; https://github.com/greduan/emacs-theme-gruvbox
(use-package gruvbox-theme
  :init
  (load-theme 'gruvbox :no-confirm))

;; Nerd Icons
;; https://github.com/rainstormstudio/nerd-icons.el#installing-fonts
;;
;; NOTE: You will need to run 'M-x nerd-icons-install-fonts' and then manually install the
;; downloaded font on Windows.
(use-package nerd-icons)

;; Doom Modeline for a cleaner modeline.
;; https://github.com/seagle0128/doom-modeline
(use-package doom-modeline
  :init
  (doom-modeline-mode 1))

;; Dashboard
;; https://github.com/emacs-dashboard/emacs-dashboard
(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook))

(setq initial-buffer-choice (lambda () (get-buffer-create "*dashboard*")))

;; Rainbow Delimiters for colored braces.
;; https://github.com/Fanael/rainbow-delimiters
;;
;; This is a must have for Lisp programming.
(use-package rainbow-delimiters
  :hook
  (prog-mode . rainbow-delimiters-mode))

;; Beacon
;; https://github.com/Malabarba/beacon
;;
;; Highlights the cursor as you jump through or between windows/buffers.
(use-package beacon
  :init
  (beacon-mode 1))

;; If the font is installed then we will use it, otherwise it should just skip.
;; condition-case operates like a try/catch in other languages.
(defun my/configure-custom-font ()
  "Set the font if it exists, otherwise ignore."
  (condition-case nil
    (setq default-frame-alist '((font . "CaskaydiaCove NF 10")))
    (error nil)))

(my/configure-custom-font)

(if (daemonp)
  (add-hook 'after-make-frame-functions
    (lambda (frame)
      (with-selected-frame frame
	(my/configure-custom-font)))))

;; Set line numbers to display.
;; https://www.emacswiki.org/emacs/LineNumbers
(require 'display-line-numbers)

;; Create a custom function to set which modes we do not want to see line numbers in.
(defcustom display-line-numbers-exempt-modes
  '(vterm-mode eshell-mode shell-mode term-mode ansi-term-mode org-mode)
  "Major modes on which to disable line numbers."
  :group 'display-line-numbers
  :type 'list
  :version "green")

(defun display-line-numbers--turn-on ()
  "Turn on line numbers except for certain major modes.
Exempt major modes are defined in `display-line-numbers-exempt-modes'."
  (unless (or (minibufferp)
              (member major-mode display-line-numbers-exempt-modes))
    (display-line-numbers-mode)))

(global-display-line-numbers-mode)

;; Centaur Tabs
;; https://github.com/ema2159/centaur-tabs
(use-package centaur-tabs
  :demand
  :after
  (evil)
  :config
  (centaur-tabs-mode t)
  (centaur-tabs-headline-match)
  (setq centaur-tabs-style "bar")
  :bind
  (:map evil-normal-state-map
        ("g t" . centaur-tabs-forward)
        ("g T" . centaur-tabs-backward)))

