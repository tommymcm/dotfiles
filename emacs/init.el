;; Bootstrap straight.el
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; Install use-package
(straight-use-package 'use-package)
(setq straight-use-package-by-default 'true)

;; Fix bug in Emacs < 26.2
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

;; Personal formatting
(global-display-line-numbers-mode)
(menu-bar-mode -1)

;; No ~* files everywhere
(setq make-backup-files nil)

(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(defvaralias 'c-basic-offset 'tab-width)
(defvaralias 'cperl-indent-level 'tab-width)
(defvaralias 'js-indent-level 'tab-width)
(put 'upcase-region 'disabled nil)

;; Open multiple files with vert split
(setq
 split-width-threshold 0
 split-height-threshold nil)

;; Turn off cursor blinking
(setq visible-cursor nil)

;; Sane scrolling
(unless window-system
  (xterm-mouse-mode 1))

;; tmux integration
(use-package tmux-pane
  :bind (("M-i" . tmux-pane-omni-window-up)
         ("M-j" . tmux-pane-omni-window-left)
         ("M-k" . tmux-pane-omni-window-down)
         ("M-l" . tmux-pane-omni-window-right)
         ("M-," . tmux-pane-omni-window-left)
         ("M-." . tmux-pane-omni-window-right)))

;; magit
(use-package compat)
(use-package magit
  :ensure t
  :bind ("C-c i" . magit-status))

;; Org-Mode  
(use-package org)

;; Language Server
;;   disabled until I configure it
; (use-package lsp-mode :commands lsp)
; (use-package lsp-ui :commands lsp-ui-mode)

; (use-package ccls
;   :hook ((c-mode c++-mode objc-mode cuda-mode) .
;          (lambda () (require 'ccls) (lsp))))

;; yaml mode
(use-package yaml-mode)
;; (define-derived-mode yaml-mode fundamental-mode "YamlMode"
;;   "Comments start with `#."
;;   (set (make-local-variable 'comment-start) "#"))
;; (add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))

;; Makefile mode
(require 'make-mode)
(defconst makefile-nmake-statements
  `("!IF" "!ELSEIF" "!ELSE" "!ENDIF" "!MESSAGE" "!ERROR" "!INCLUDE" ,@makefile-statements)
  "List of keywords understood by nmake.")

(defconst makefile-nmake-font-lock-keywords
  (makefile-make-font-lock-keywords
   makefile-var-use-regex
   makefile-nmake-statements
   t))

(define-derived-mode makefile-nmake-mode makefile-mode "nMakefile"
  "An adapted `makefile-mode' that knows about nmake."
  (setq font-lock-defaults
                  `(makefile-nmake-font-lock-keywords ,@(cdr font-lock-defaults))))

(setq auto-mode-alist
              (cons '("\\.mak\\'" . makefile-nmake-mode) auto-mode-alist))
(setq auto-mode-alist
      (cons '("/Makefile.*\\'" . makefile-nmake-mode) auto-mode-alist))

;; Paren matching
(show-paren-mode 1)
(require 'paren)
(set-face-background 'show-paren-match (face-background 'default))
(set-face-foreground 'show-paren-match "#def")
(set-face-attribute 'show-paren-match nil :weight 'extra-bold)

;; Load plugins
(use-package autodisass-llvm-bitcode)
(use-package llvm-mode
  :straight (:type built-in)
  :ensure nil
  :init
  (let ((llvm-mode-file (expand-file-name "~/.emacs.d/llvm-mode.el")))
    (unless (file-exists-p llvm-mode-file)
      (url-copy-file
       "https://raw.githubusercontent.com/llvm/llvm-project/main/llvm/utils/emacs/llvm-mode.el"
       llvm-mode-file))
    (load-file llvm-mode-file))
  :mode "\\(.ll|.bc)\\'")
(use-package llvm-mode
  :straight (:type built-in)
  :ensure nil
  :init
  (let ((llvm-mode-file (expand-file-name "~/.emacs.d/llvm-mode.el")))
    (unless (file-exists-p llvm-mode-file)
      (url-copy-file
       "https://raw.githubusercontent.com/llvm/llvm-project/main/llvm/utils/emacs/tablegen-mode.el"
       llvm-mode-file))
    (load-file llvm-mode-file))
  :mode "\\.td\\'")

(setq load-path
      (cons (expand-file-name "/project/extra/llvm/9.0.0/llvm-9.0.0.src/tools/clang/tools/clang-format") load-path))
(require 'clang-format)

;; (setq load-path
;;       (cons (expand-file-name "~/emacs-plugins/autodisass-llvm-bitcode") load-path))
;; (require 'autodisass-llvm-bitcode)

;; User Functions
(defun prev-window ()
  (interactive)
  (other-window -1))

;; Keybindings
(global-set-key (kbd "C-f") 'clang-format-buffer)
(global-set-key (kbd "M-;") 'comment-line)
;; (global-unset-key (kbd "M-."))
;; (global-unset-key (kbd "M-,"))
;; (global-unset-key (kbd "M-=")) 
;; (global-set-key (kbd "M-.") 'other-window)
;; (global-set-key (kbd "M-,") 'prev-window)
;; (global-set-key (kbd "M-=") 'balance-windows)
;; (global-set-key (kbd "M-j") 'windmove-left)
;; (global-set-key (kbd "M-l") 'windmove-right)
;; (global-set-key (kbd "M-i") 'windmove-up)
;; (global-set-key (kbd "M-k") 'windmove-down)

;; Aliases
(defalias 'rs 'replace-string)
(defalias 'swp 'window-swap-states)
(defalias 'linenum 'display-line-numbers-mode)

;; Merge mode
(defalias 'merge 'smerge-mode)
(global-unset-key (kbd "C-j"))
(setq smerge-command-prefix (kbd "C-j"))

;; Theme
(use-package django-theme
  :init
  (setq custom-safe-themes t)  
  :config
  (load-theme 'django t)
  (set-face-attribute 'default nil :background "#051f14")
  (set-face-attribute 'lazy-highlight nil :weight 'bold)
  )
                    
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("efd849c804148b88536914ccdee08285fd7376e2e3334522c9afc00fd7e594da"
     default)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
