(setq py-load-pymacs-p nil)
(require 'epa-file)
(epa-file-enable)

(require 'package)
(add-to-list 'package-archives 
    '("marmalade" .
      "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

;;el-get
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil t)
  (url-retrieve
   "https://github.com/dimitri/el-get/raw/master/el-get-install.el"
   (lambda (s)
     (end-of-buffer)
     (eval-print-last-sexp))))

;; now either el-get is `require'd already, or have been `load'ed by the
;; el-get installer.
(setq
 el-get-sources
 '(el-get				; el-get is self-hosting
   escreen            			; screen for emacs, C-\ C-h
   php-mode-improved			; if you're into php...
   switch-window			; takes over C-x o
   auto-complete			; complete as you type with overlays
   zencoding-mode			; http://www.emacswiki.org/emacs/ZenCoding

   (:name buffer-move			; have to add your own keys
	  :after (lambda ()
		   (global-set-key (kbd "<C-S-up>")     'buf-move-up)
		   (global-set-key (kbd "<C-S-down>")   'buf-move-down)
		   (global-set-key (kbd "<C-S-left>")   'buf-move-left)
		   (global-set-key (kbd "<C-S-right>")  'buf-move-right)))

   (:name smex				; a better (ido like) M-x
	  :after (lambda ()
		   (setq smex-save-file "~/.emacs.d/.smex-items")
		   (global-set-key (kbd "M-x") 'smex)
		   (global-set-key (kbd "M-X") 'smex-major-mode-commands)))

   (:name magit				; git meet emacs, and a binding
	  :after (lambda ()
		   (global-set-key (kbd "C-x C-z") 'magit-status)))

   (:name goto-last-change		; move pointer back to last change
	  :after (lambda ()
		   ;; when using AZERTY keyboard, consider C-x C-_
		   (global-set-key (kbd "C-x C-/") 'goto-last-change)))))

(unless (string-match "apple-darwin" system-configuration)
  (loop for p in '(color-theme		; nice looking emacs
		   color-theme-tango	; check out color-theme-solarized
		   )
	do (add-to-list 'el-get-sources p)))

;;
;; Some recipes require extra tools to be installed
;;
;; Note: el-get-install requires git, so we know we have at least that.
;;
(when (el-get-executable-find "cvs")
  (add-to-list 'el-get-sources 'emacs-goodies-el)) ; the debian addons for emacs

(when (el-get-executable-find "svn")
  (loop for p in '(psvn    		; M-x svn-status
		   yasnippet		; powerful snippet mode
		   )
	do (add-to-list 'el-get-sources p)))

;; install new packages and init already installed packages
(el-get 'sync)

(add-to-list 'load-path "/usr/share/emacs24/site-lisp")

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

(load "~/.emacs.d/elpa/haskell-mode-20130420.2127/haskell-site-file")

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
 '(inhibit-startup-screen t)
 '(safe-local-variable-values (quote ((emacs-lisp-docstring-fill-column . 75)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


(require 'font-lock)
(global-font-lock-mode t)
(setq font-lock-maximum-decoration t)

(setq line-number-mode t)
(setq column-number-mode t)


(auto-fill-mode 1)
(flyspell-mode 1)


(setq TeX-PDF-mode t)

(add-hook 'doc-view-mode-hook 'auto-revert-mode)
 
(defun make-backup-file-name (file)
(concat "/home/pranjal/Dropbox/emacs/backups/" (file-name-nondirectory file) "~"))

(global-set-key (kbd "C-<tab>") 'yas/insert-snippet)



(setq c-mode-hook
      '(lambda ()
	 (subword-mode 1) 
	 ))
(setq c++-mode-hook
      '(lambda ()
	 (subword-mode 1) 
	 (company-mode 1)
	 ))

(defun update-gtags ()
  (interactive)
  (shell-command "global -u"))

(defun complete-or-indent ()
  (interactive)
  (if (company-manual-begin)
      (company-complete-common)
(indent-according-to-mode)))

(defun indent-or-complete ()
  (interactive)
  (if (looking-at "\\_>")
      (company-complete-common)
    (indent-according-to-mode)))
(custom-set-variables
     '(haskell-mode-hook '(turn-on-haskell-indentation)))



(setq tramp-default-method "scpc")
(setq tramp-auto-save-directory "~/tmp")

(autoload 'octave-mode "octave-mod" nil t)
(setq auto-mode-alist
      (cons '("\\.m$" . octave-mode) auto-mode-alist))


(autoload 'wl "wl" "Wanderlust" t)
(setq bbdb-file "~/.emacs.d/bbdb")           ;; keep ~/ clean; set before loading
(require 'bbdb) 
(bbdb-initialize)
(setq 
    bbdb-offer-save 1                        ;; 1 means save-without-asking

    
    bbdb-use-pop-up t                        ;; allow popups for addresses
    bbdb-electric-p t                        ;; be disposable with SPC
    bbdb-popup-target-lines  1               ;; very small
    
    bbdb-dwim-net-address-allow-redundancy t ;; always use full name
    bbdb-quiet-about-name-mismatches 2       ;; show name-mismatches 2 secs

    bbdb-always-add-address t                ;; add new addresses to existing...
                                             ;; ...contacts automatically
    bbdb-canonicalize-redundant-nets-p t     ;; x@foo.bar.cx => x@bar.cx

    bbdb-completion-type nil                 ;; complete on anything

    bbdb-complete-name-allow-cycling t       ;; cycle through matches
                                             ;; this only works partially

    bbbd-message-caching-enabled t           ;; be fast
    bbdb-use-alternate-names t               ;; use AKA


    bbdb-elided-display t                    ;; single-line addresses

    ;; auto-create addresses from mail
    bbdb/mail-auto-create-p 'bbdb-ignore-some-messages-hook   
    bbdb-ignore-some-messages-alist ;; don't ask about fake addresses
    ;; NOTE: there can be only one entry per header (such as To, From)
    ;; http://flex.ee.uec.ac.jp/texi/bbdb/bbdb_11.html

    '(( "From" . "no.?reply\\|DAEMON\\|daemon\\|facebookmail\\|twitter"))
)
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.ci\\'" . c++-mode))

(setq mouse-autoselect-window t)

(define-minor-mode sticky-buffer-mode
  "Make the current window always display this buffer."
  nil " sticky" nil
  (set-window-dedicated-p (selected-window) sticky-buffer-mode))
