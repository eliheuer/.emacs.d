;; Eli's EMACS config file :::::::::::::::::::::::::::::::::::::::::::::::::::::

;; Set header line:
(setq-default header-line-format
              (list "GNU EMACS: برمجيات حرة • يا بهاء الأبهى"))

;; Turn off GNU artwork at start:
(setq inhibit-startup-screen t)

;; Set Font
;(set-face-attribute 'default nil :font "Kalimat 25")
;(set-face-attribute 'default nil :font "Input Mono Narrow Bold 24")
(set-face-attribute 'default nil :font "NoName Fixed 26")
;(set-face-attribute 'default nil :font "Iosevka Light 22")

(mapc
  (lambda (face)
    (set-face-attribute face nil :weight 'normal :underline nil))
  (face-list))

;; Turn off GNU artwork at start:
(tool-bar-mode -1)

;; Turn off GNU artwork at start:
(toggle-scroll-bar -1)

;; Line numbers
(when (version<= "26.0.50" emacs-version )
  (global-display-line-numbers-mode))

;;(require 'column-marker)
;;(add-hook 'python-mode-hook (lambda () (interactive) (column-marker-1 81)))

;; Backups
(setq make-backup-files nil) ; stop creating backup~ files
(setq auto-save-default nil) ; stop creating #autosave# files
(setq tramp-auto-save-directory "~/.emacs.d/tramp-autosave")

;; Melpa
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (when no-ssl
    (warn "\
Your version of Emacs does not support SSL connections,
which is unsafe because it allows man-in-the-middle attacks.
There are two things you can do about this warning:
1. Install an Emacs version that does support SSL and be safe.
2. Remove this warning from your init file so you won't see it again."))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives (cons "gnu" (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)

;; Number style
(add-hook 'prog-mode-hook 'highlight-numbers-mode)

;; EVIL mode
(add-to-list 'load-path "~/.emacs.d/evil")
(require 'evil)
(evil-mode 1)
(defun my-jk ()
  (interactive)
  (let* ((initial-key ?j)
         (final-key ?k)
         (timeout 0.5)
         (event (read-event nil nil timeout)))
    (if event
        ;; timeout met
        (if (and (characterp event) (= event final-key))
            (evil-normal-state)
          (insert initial-key)
          (push event unread-command-events))
      ;; timeout exceeded
      (insert initial-key))))
(define-key evil-insert-state-map (kbd "j") 'my-jk)

;; Org
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-level-1 ((t (:inherit outline-1 :height 1.0))))
 '(org-level-2 ((t (:inherit outline-2 :height 1.0))))
 '(org-level-3 ((t (:inherit outline-3 :height 1.0))))
 '(org-level-4 ((t (:inherit outline-4 :height 1.0))))
 '(org-level-5 ((t (:inherit outline-5 :height 1.0)))))
(setq org-log-done 'time)

;; Theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(load-theme 'dracula t)

;; Neotree
(add-to-list 'load-path "~/.emacs.d/neotree")
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)

;; ido
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (highlight-numbers rust-mode telephone-line elpy magit rainbow-delimiters ranger smex rainbow-mode))))

;; Magit
(global-set-key (kbd "C-x g") 'magit-status)

;; Ranger
(global-set-key (kbd "C-x r") 'ranger)

;; Smex
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;; ELPY
(package-initialize)
(elpy-enable)
;; (package-initialize) should already exist at the top of the init
;; file on Debian-derived systems, thus (elpy-enable) should be all
;; that is required.

(require 'telephone-line)
(setq telephone-line-primary-left-separator 'telephone-line-flat
      telephone-line-secondary-left-separator 'telephone-line-nil
      telephone-line-primary-right-separator 'telephone-line-flat
      telephone-line-secondary-right-separator 'telephone-line-nil)
(setq telephone-line-height 50
      telephone-line-evil-use-short-tag t)
(telephone-line-mode 1)
