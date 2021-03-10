;;  ;; Set up package.el to work with MELPA
;;  (require 'package)
;;  (add-to-list 'package-archives
;;               '("melpa" . "https://melpa.org/packages/"))
;;  (package-initialize)
;;  (package-refresh-contents)
;;  
;;  ;; Download Evil
;;  (unless (package-installed-p 'evil)
;;    (package-install 'evil))
;;  
;;  ;; Enable Evil
;;  (require 'evil)
;;  (evil-mode 1)
;;  (custom-set-variables
;;   ;; custom-set-variables was added by Custom.
;;   ;; If you edit it by hand, you could mess it up, so be careful.
;;   ;; Your init file should contain only one such instance.
;;   ;; If there is more than one, they won't work right.
;;   '(package-selected-packages (quote (evil))))
;;  (custom-set-faces
;;   ;; custom-set-faces was added by Custom.
;;   ;; If you edit it by hand, you could mess it up, so be careful.
;;   ;; Your init file should contain only one such instance.
;;   ;; If there is more than one, they won't work right.
;;   )
;;  (defvar bootstrap-version)
;;  (let ((bootstrap-file
;;        (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
;;       (bootstrap-version 5))
;;       (unless (file-exists-p bootstrap-file)
;;         (with-current-buffer
;;           (url-retrieve-synchronously
;;            "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
;;            'silent 'inhibit-cookies)
;;           (goto-char (point-max))
;;           (eval-print-last-sexp)))
;;  (load bootstrap-file nil 'nomessage))
;;  
;;  (straight-use-package 'use-package)
;;  (setq straight-use-package-by-default t)
;;  (use-package vscode-dark-plus-theme
;;    :config
;;    (load-theme 'vscode-dark-plus t))
;;  
(defvar bootstrap-version)
(let ((bootstrap-file
      (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
     (bootstrap-version 5))
     (unless (file-exists-p bootstrap-file)
       (with-current-buffer
         (url-retrieve-synchronously
          "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
          'silent 'inhibit-cookies)
         (goto-char (point-max))
         (eval-print-last-sexp)))
(load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)
(setq straight-use-package-by-default t)


;; Ab hier alle Pakete mit use-package laden und auch konfigurieren

(use-package undo-tree
       :init
	     (global-undo-tree-mode 1))

(use-package evil
       :after undo-tree
       :init
	     (setq evil-want-integration t)
	     (setq evil-want-keybinding nil)
	     (setq evil-want-C-u-scroll nil)
	     (setq evil-want-C-i-jump nil)
	     (setq evil-respect-visual-line-mode t)
	     (setq evil-undo-system 'undo-tree)
	     :config
	     (evil-mode 1)
	     (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
	     (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)

	     ;; Use visual line motions even outside of visual-line-mode-buffers
	     (evil-global-set-key 'motion "j" 'evil-next-visual-line)
	     (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

	     (evil-set-initial-state 'messages-buffer-mode 'normal)
	     (evil-set-initial-state 'dashboard-mode 'normal))

(use-package evil-collection
       :after evil
	     :init
	     :config
	     (evil-collection-init))

(use-package vscode-dark-plus-theme
  :defer t)
(load-theme 'vscode-dark-plus t)
