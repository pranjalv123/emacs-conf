(setq py-load-pymacs-p nil)

(require 'package)
(add-to-list 'package-archives 
    '("marmalade" .
      "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

(tool-bar-mode 0)
(menu-bar-mode 0)

(ido-mode 1)

(dynamic-completion-mode)


;initialize smex
(global-set-key [(meta x)] (lambda ()
                             (interactive)
                             (or (boundp 'smex-cache)
                                 (smex-initialize))
                             (global-set-key [(meta x)] 'smex)
                             (smex)))

(global-set-key [(shift meta x)] (lambda ()
                                   (interactive)
                                   (or (boundp 'smex-cache)
                                       (smex-initialize))
                                   (global-set-key [(shift meta x)] 'smex-major-mode-commands)
                                   (smex-major-mode-commands)))

(load "~/.emacs.d/elpa/haskell-mode-2.8.0/haskell-site-file")

(require 'latex-pretty-symbols)


(add-to-list 'load-path "/home/pranjal/.emacs.d/bluespec")
(autoload 'bsv-mode "bsv-mode" "BSV mode" t )
(setq auto-mode-alist (cons  '("\\.bsv\\'" . bsv-mode) auto-mode-alist))


(require 'auto-complete)
(setq auto-complete-mode t)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ein:use-auto-complete t)
 '(ein:use-auto-complete-superpack nil)
 '(inhibit-startup-screen t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;Set up gnus for gmail
(setq gnus-select-method '(nnimap "gmail"
				  (nnimap-address "imap.gmail.com")
				  (nnimap-server-port 993)
				  (nnimap-stream ssl)))

(require 'font-lock)
(global-font-lock-mode t)
(setq font-lock-maximum-decoration t)

(setq line-number-mode t)
(setq column-number-mode t)


(auto-fill-mode 1)
(flyspell-mode 1)


(setq TeX-PDF-mode t)

(add-hook 'doc-view-mode-hook 'auto-revert-mode)
 
