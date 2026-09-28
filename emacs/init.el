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

(setq rainbow-ansi-colors t)  ;; if using rainbow
(add-to-list 'term-file-aliases '("xterm-256color" . "xterm"))

(add-to-list 'load-path "~/.emacs.d/lisp")
(add-to-list 'load-path "~/.emacs.d/llvm")

;; Personal formatting
(global-display-line-numbers-mode)
(menu-bar-mode -1)

;; No ~* files everywhere
(setq make-backup-files nil)

(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(defvaralias 'c-basic-offset 'tab-width)
;; (defvaralias 'rust-indent-offset 'tab-width)
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

;; Quail
;;(require 'pl-greek)


;; Window Resizing
(defun win-resize-top-or-bot ()
  "Figure out if the current window is on top, bottom or in the
middle"
  (let* ((win-edges (window-edges))
         (this-window-y-min (nth 1 win-edges))
         (this-window-y-max (nth 3 win-edges))
         (fr-height (frame-height)))
    (cond
     ((eq 0 this-window-y-min) "top")
     ((eq (- fr-height 1) this-window-y-max) "bot")
     (t "mid"))))

(defun win-resize-left-or-right ()
  "Figure out if the current window is to the left, right or in the
middle"
  (let* ((win-edges (window-edges))
         (this-window-x-min (nth 0 win-edges))
         (this-window-x-max (nth 2 win-edges))
         (fr-width (frame-width)))
    (cond
     ((eq 0 this-window-x-min) "left")
     ((eq (+ fr-width 4) this-window-x-max) "right")
     (t "mid"))))

(defun win-resize-enlarge-horiz ()
  (interactive)
  (cond
   ((equal "top" (win-resize-top-or-bot)) (enlarge-window -1))
   ((equal "bot" (win-resize-top-or-bot)) (enlarge-window 1))
   ((equal "mid" (win-resize-top-or-bot)) (enlarge-window -1))
   (t (message "nil"))))

(defun win-resize-minimize-horiz ()
  (interactive)
  (cond
   ((equal "top" (win-resize-top-or-bot)) (enlarge-window 1))
   ((equal "bot" (win-resize-top-or-bot)) (enlarge-window -1))
   ((equal "mid" (win-resize-top-or-bot)) (enlarge-window 1))
   (t (message "nil"))))
(defun win-resize-enlarge-vert ()
  (interactive)
  (cond
   ((equal "left" (win-resize-left-or-right)) (enlarge-window-horizontally -1))
   ((equal "right" (win-resize-left-or-right)) (enlarge-window-horizontally 1))
   ((equal "mid" (win-resize-left-or-right)) (enlarge-window-horizontally -1))))

(defun win-resize-minimize-vert ()
  (interactive)
  (cond
   ((equal "left" (win-resize-left-or-right)) (enlarge-window-horizontally 1))
   ((equal "right" (win-resize-left-or-right)) (enlarge-window-horizontally -1))
   ((equal "mid" (win-resize-left-or-right)) (enlarge-window-horizontally 1))))

(global-set-key (kbd "C-M-k") 'win-resize-minimize-vert)
(global-set-key (kbd "C-M-i") 'win-resize-enlarge-vert)
(global-set-key (kbd "C-M-j") 'win-resize-minimize-horiz)
(global-set-key (kbd "C-M-l") 'win-resize-enlarge-horiz)
(global-set-key (kbd "C-M-k") 'win-resize-enlarge-horiz)
(global-set-key (kbd "C-M-i") 'win-resize-minimize-horiz)
(global-set-key (kbd "C-M-j") 'win-resize-enlarge-vert)
(global-set-key (kbd "C-M-l") 'win-resize-minimize-vert)
(global-unset-key (kbd "M-="))
(global-set-key (kbd "M-=") 'balance-windows)

;; magit
(use-package compat)
;; (use-package magit
;; :ensure t
;;   :bind ("C-c i" . magit-status))

;; Org-Mode
;; (use-package org)

;; Language Server
;; (use-package lsp-mode
;;   :config
;;                                         ;  (add-hook 'c++-mode-hook 'lsp)
;;   (setq lsp-headerline-breadcrumb-enable nil))

;; (use-package ccls
;;   :hook ((c-mode c++-mode objc-mode cuda-mode) .
;;          (lambda () (require 'ccls) (lsp))))

;; yaml mode
;; (use-package yaml-mode)
;; (define-derived-mode yaml-mode fundamental-mode "YamlMode"
;;   "Comments start with `#."
;;   (set (make-local-variable 'comment-start) "#"))
;; (add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))

;; Javascript mode
;; Install typescript-mode
(use-package typescript-mode
  :ensure t
  :hook (typescript-mode . (lambda () (setq indent-tabs-mode nil)))) ;; Example: disable tabs for indentation

;; Install and configure LSP mode with ts-ls
;; (use-package lsp-mode
;;   :ensure t
;;   :init
;;   (setq lsp-enable-text-document-color t) ;; Example LSP setting
;;   :hook ((typescript-mode . lsp)))

;; ;; Install and configure Company mode for auto-completion
;; (use-package company
;;   :ensure t
;;   :init
;;   (global-company-mode)
;;   (setq company-idle-delay 0.1
;;         company-minimum-prefix-length 1))

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

;; Rust-mode
(use-package rust-mode)

;; Zig-mode
(unless (version< emacs-version "24")
  (autoload 'zig-mode "zig-mode" nil t)
  (add-to-list 'auto-mode-alist '("\\.\\(zig\\|zon\\)\\'" . zig-mode)))
(use-package zig-mode)

;; Racket-mode
(use-package racket-mode
  :ensure t
  :config
  (add-hook 'racket-mode-hook
            (lambda ()
              (racket-xp-mode)
              (set-input-method 'pl-greek)
              (define-key racket-mode-map (kbd "C-c r") 'racket-run))))


;; just-mode
;; (setq load-path
;;       (cons (expand-file-name "~/.emacs.d/just-mode.el") load-path))
;;(require 'just-mode)

;; Paren matching
(show-paren-mode 1)
;;(require 'paren)
(set-face-background 'show-paren-match (face-background 'default))
(set-face-foreground 'show-paren-match "#def")
(set-face-attribute 'show-paren-match nil
                    :weight 'ultra-bold
                    :foreground "#ff6800")

;; Load plugins
;; (setq load-path
;;       (cons (expand-file-name "~/.emacs.d/llvm-mode") load-path))
;;(require 'llvm-mode)
;;(require 'tablegen-mode)

;; (setq load-path
;;       (cons (expand-file-name "~/.emacs.d/autodisass-llvm-bitcode") load-path))
;;(require 'autodisass-llvm-bitcode)

;; Formatters.
(use-package format-all
  :commands format-all-mode
  :hook (prog-mode . format-all-mode)
  :config
  (add-hook 'format-all-mode-hook 'format-all-ensure-formatter))
(setq format-all-show-errors 'never)
(global-set-key (kbd "C-f") 'format-all-buffer)

;; User Functions
(defun prev-window ()
  (interactive)
  (other-window -1))

;; Keybindings
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

;; tmux integration
(use-package tmux-pane
  :bind (("M-i" . tmux-pane-omni-window-up)
         ("M-j" . tmux-pane-omni-window-left)
         ("M-k" . tmux-pane-omni-window-down)
         ("M-l" . tmux-pane-omni-window-right)
         ("M-," . tmux-pane-omni-window-left)
         ("M-." . tmux-pane-omni-window-right)))

;; Theme
(use-package srcery-theme
  :config
  (load-theme 'srcery t)
  ;; Recolor
  (custom-set-faces
   '(font-lock-keyword-face ((t (:foreground "brightred"))))
   '(font-lock-variable-name-face ((t (:foreground "brightyellow"))))
   )
  )

;; Custom faces.
(defface todo-face '((t (:background "brightyellow" :foreground "black" :weight bold :slant normal))) "TODO face")
(defface note-face '((t (:background "brightblue" :foreground "black" :weight bold :slant normal))) "NOTE face")
(defface fixme-face '((t (:background "brightred" :foreground "black" :weight bold :slant normal))) "FIXME face")
(defface hack-face '((t (:background "brightmagenta" :foreground "black" :weight bold :slant normal))) "HACK face")
(add-hook 'prog-mode-hook
          (lambda ()
            (font-lock-add-keywords nil
                                    '(("\\(TODO\\)" 1 'todo-face prepend)
                                      ("\\(NOTE\\)" 1 'note-face prepend)
                                      ("\\(FIXME\\)" 1 'fixme-face prepend)
                                      ("\\(HACK\\)" 1 'hack-face prepend)))
            (font-lock-flush)))

(use-package powerline
  :config
  (powerline-default-theme)
  ;; (set-face-attribute 'mode-line nil :background "blue" :foreground "brightwhite")
  (powerline-reset)
  )
