;;; Commentary: jakeware emacs init file

;;; Code:

;; Set up use-package.
(require 'package)
(setq package-enable-at-startup nil)

;; Add repos.
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.org/packages/")))

(package-initialize)

;; Bootstrap use-package.
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t)
 '(use-file-dialog nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background nil :foreground "#F8F8F2" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 85 :width normal :foundry "unknown" :family "DejaVu Sans Mono")))))

;; Auto refresh.
(global-auto-revert-mode t)
(setq auto-revert-interval 0.1)

;; Tab width
(setq-default tab-width 2)

;; Use spaces instead of tabs.
(setq-default indent-tabs-mode nil)

;; Column number mode.
(column-number-mode 1)

;; Move to trash instead of deleting.
(setq delete-by-moving-to-trash t)

;; Set dired switches.
(setq dired-listing-switches "-alh")

;; Allow for recursive trashing.
(setq dired-recursive-deletes 'always)

;; Updates dired buffers. automatically.
(setq dired-auto-revert-buffer t)

;; Set fill column and auto fill.
(setq-default fill-column 80)
;; (setq-default auto-fill-function 'do-auto-fill)

;; Set some options for compilation mode.
(setq compilation-scroll-output 'first-error)

;; org source code highlighting.
(setq org-src-fontify-natively t)
(setq org-highlight-latex-and-related '(latex script entities))

;; Remove tool and menu bar.
(if window-system
  (tool-bar-mode -1)
  (menu-bar-mode -1)
)

;; Use the ipython interpreter.
(when (executable-find "ipython")
  (setq python-shell-interpreter "ipython"))
  
;; gdb.
(setq gdb-many-windows t)

;; gud.
(use-package gud
  :ensure t
  :bind (([f5] . gud-cont)
         ([f6] . gud-finish)
         ([f7] . gud-tbreak)
         ([f9] . gud-break)
         ([f10] . gud-next)
         ([f11] . gud-step)))

;; Set line numbers.
(use-package linum
  :ensure t
  :config (global-linum-mode t))

;; Show parentheses.
(require 'paren)
(use-package paren
  :ensure t
  :config (show-paren-mode t))

;; Use windmove to move cursor around split panes.
;; shift + arrow keys
(use-package windmove
  :config (windmove-default-keybindings 'meta)
  :bind(("M-s-i" . windmove-up)
        ("M-s-k" . windmove-down)
        ("M-s-j" . windmove-left)
        ("M-s-l" . windmove-right))) 

;; CMake
(use-package cmake-mode
  :ensure t)

;; yaml-mode.
(use-package yaml-mode
  :ensure t)

;; xml.
(use-package xml
  :mode (("\\.launch\\'" . xml-mode)))

;; latex.
(use-package tex-site
  :ensure auctex
  :mode (("\\.tex\\'" . LaTeX-mode))
  :config (progn (add-hook 'LaTeX-mode-hook 'turn-on-reftex)
                 (setq TeX-auto-save t)
                 (setq TeX-parse-self t)                   
                 (setq-default TeX-master nil)
                 (setq latex-run-command "pdflatex")))

;; doc-view-mode.
(setq doc-view-resolution 300)

;; pdf-tools.
;;(use-package pdf-tools
;;  :ensure t
;;  :config (pdf-tools-install))

;; c++.
(use-package c++-mode
  :config (c-set-offset 'innamespace 0)
  :mode (("\\.h\\'" . c++-mode)
         ("\\.cu\\'" . c++-mode)
         ("\\.cl\\'" . c++-mode)))

;; Pair completion.
(use-package smartparens
  :ensure t
  :config (progn (smartparens-global-mode t)
                 (sp-local-pair `LaTeX-mode "$" "$")))

;; Rainbow delimiters.
(use-package rainbow-delimiters
  :ensure t
  :config (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

;; Markdown mode.
(use-package markdown-mode
  :ensure t
  :mode (("\\.text\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode)
         ("\\.md\\'" . markdown-mode)))

;; pandoc-mode
(use-package pandoc-mode
  :ensure t
  :config (add-hook 'markdown-mode-hook 'pandoc-mode))

;; Indent highlighting.
;; (use-package highlight-indentation
;;   :load-path "~/.emacs.d/Highlight-Indentation-for-Emacs"
;;   :init (progn (add-hook 'c-mode-hook 'highlight-indentation-mode)
;;                (add-hook 'c++-mode-hook 'highlight-indentation-mode)
;;                (add-hook 'python-mode-hook 'highlight-indentation-mode)
;;                (add-hook 'xml-mode-hook 'highlight-indentation-mode)
;;                (add-hook 'java-mode-hook 'highlight-indentation-mode)
;;                (add-hook 'cmake-mode-hook 'highlight-indentation-mode))
;;   :config (highlight-indentation-mode t))

;; Yasnippet.
(use-package yasnippet
  :ensure t
  :init (setq yas-snippet-dirs '("~/.emacs.d/snippets"))
  :config (yas-global-mode t))

;; Flycheck.
;; (use-package flycheck
;;   :ensure t
;;   :config (progn (add-hook 'after-init-hook #'global-flycheck-mode)
;;                  (add-hook 'python-mode-hook (lambda ()
;;                                                (flycheck-select-checker 'python-pylint)))))

;; Flycheck Google cpplint
;; (use-package flycheck-google-cpplint
;;   :ensure t
;;   :config (progn (setq flycheck-googlelint-verbose "3")
;;                  ;; (setq flycheck-googlelint-root "src")
;;                  (setq flycheck-googlelint-linelength "80")
;;                  (add-hook 'c-mode-hook (lambda ()
;;                                           (flycheck-select-ichecker 'c/c++-googlelint))
;;                  (add-hook 'c++-mode-hook (lambda ()
;;                                             (flycheck-select-checker 'c/c++-googlelint))))))

;; Magit.
(use-package magit
  :ensure t
  :init (setq magit-last-seen-setup-instructions "1.4.0")
  :bind (("C-x g" . magit-status)))

;; Needed for helm-projectile-grep.
(use-package grep)

;; Helm.
(use-package helm
  :ensure t
  :config (progn (helm-autoresize-mode 1))
  :bind (("M-x"     . helm-M-x)
         ("C-x C-b" . helm-buffers-list)
         ("C-c h i" . helm-semantic-or-imenu)
         ("C-c h o" . helm-occur)))

;; Projectile.
(use-package projectile
  :ensure t
  :init (progn (projectile-global-mode))
  :config (progn (add-to-list 'projectile-globally-ignored-directories ".git") 
                 (add-to-list 'projectile-globally-ignored-files "GPATH")                  
                 (add-to-list 'projectile-globally-ignored-files "GTAGS")                  
                 (add-to-list 'projectile-globally-ignored-files "GRTAGS")                  
                 (setq projectile-find-dir-includes-top-level t)
                 (setq projectile-completion-system 'helm)
                 (setq projectile-switch-project-action 'helm-projectile)
                 (setq projectile-enable-caching t)
                 (setq projectile-indexing-method 'alien)))

;; helm-projectile.
(use-package helm-projectile
  :ensure t
  :config (helm-projectile-on))

;; semantic.
(use-package semantic
  :ensure t
  :config (progn (global-semanticdb-minor-mode 1)
                 (global-semantic-idle-scheduler-mode 1)
                 (semantic-mode 1)))

;; irony-mode.
;; NOTE: You must run irony-install-server once after installation.
;; NOTE: You must provide a compilation database so that irony can find all
;; your includes. With a CMake project, call cmake with
;; -DCMAKE_EXPORT_COMPILE_COMMANDS=ON which will generate a compile_commands.json
;; file in your build directory. Then, go to your project and call:
;; irony-cdb-json-add-compile-commands-path RET <path to source> RET <path to build/compile_commands.json>
;; and you're set!
(use-package irony
  :ensure t
  :defer t
  :init
  (add-hook 'c++-mode-hook 'irony-mode)
  (add-hook 'c-mode-hook 'irony-mode)
  (add-hook 'objc-mode-hook 'irony-mode)
  :config
  ;; replace the `completion-at-point' and `complete-symbol' bindings in
  ;; irony-mode's buffers by irony-mode's function
  (defun my-irony-mode-hook ()
    (define-key irony-mode-map [remap completion-at-point]
      'irony-completion-at-point-async)
    (define-key irony-mode-map [remap complete-symbol]
      'irony-completion-at-point-async))
  (add-hook 'irony-mode-hook 'my-irony-mode-hook)
  (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options))

;; Function to check that the correct irony database is found.
(defun check-compile-options ()
  (interactive)
  (irony-cdb-json--ensure-project-alist-loaded)
  (irony--aif (irony-cdb-json--locate-db)
      (progn
        (message "I: found compilation database: %s" it)
        (let ((db (irony-cdb-json--load-db it)))
          (irony--aif (irony-cdb-json--exact-flags db)
              (progn
                (message "I: found exact match: %s" it)
                it)
            (let ((dir-cdb (irony-cdb-json--compute-directory-cdb db)))
              (irony--aif (irony-cdb-json--guess-flags dir-cdb)
                  (message "I: found by guessing: %s" it)
                (message "E: guessing failed"))))))
    (message "E: failed to locate compilation database")))

;; company-mode.
(use-package company
  :ensure t
  :defer t
  :init (add-hook 'after-init-hook 'global-company-mode)
  :config
  (use-package company-irony :ensure t :defer t)
  (setq company-idle-delay              nil
        company-minimum-prefix-length   2
        company-show-numbers            t
        company-tooltip-limit           20
        company-dabbrev-downcase        nil
        company-backends                '((company-irony))
        )
  :bind ("C-;" . company-complete-common))

;; zenburn theme.
(use-package zenburn-theme
  :ensure t
  ;; :if window-system
  :config (load-theme 'zenburn t))

;; color stuff.
(use-package ansi-color
  :ensure t
  :config (progn 
            (defun my/ansi-colorize-buffer ()
              (let ((buffer-read-only nil))
                (ansi-color-apply-on-region (point-min) (point-max))))
            (add-hook 'compilation-filter-hook 'my/ansi-colorize-buffer)))
