;; load-path を追加する関数を定義 
(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory (expand-file-name (concat user-emacs-directory path)))) 
	(add-to-list 'load-path default-directory)
        (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
	    (normal-top-level-add-subdirs-to-load-path))))))
;; elispとconfディレクトリをサブディレクトリごとload-pathに
(add-to-load-path "elisp" "conf")

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

; ------------------------------------------------------------------------
; auto-install
; http://www.emacswiki.org/emacs/download/auto-install.el
; ------------------------------------------------------------------------
(when (require 'auto-install nil t)
  ;;インストールディレクトリを設定。.emacs.d/elispに入れる。
  (setq auto-install-directory "~/.emacs.d/elisp/")
  ;;EmacsWikiに登録されているelispの名前を取得する
  (auto-install-update-emacswiki-package-name t)
  ;;必要であればプロキシの設定を行う
  ;;(setq url-proxy-services '(("http" . "hogehoge")))
  ;;install-elispの関数を利用可能にする
  (auto-install-compatibility-setup))

;; encode
(set-language-environment "Japanese")
(require 'ucs-normalize) 
(prefer-coding-system 'utf-8-hfs)
(setq file-name-coding-system 'utf-8-hfs)
(setq locale-coding-system 'utf-8-hfs)

;; not display startup message
(setq inhibit-startup-screen t)

;; not display menu bar
(menu-bar-mode 0)

;; line number
(global-linum-mode t)

;; use y/n instead of yes/no
(defalias 'yes-or-no-p 'y-or-n-p)

;; display function name
(which-function-mode 1)

(require 'recentf)
(setq recentf-save-file "~/.recentf")
(run-with-idle-timer 30 t 'recentf-save-list)
(recentf-mode 1)

;; key bind
;; goto line
(global-set-key (kbd "C-x g") 'goto-line)

;; use C-h as BackSpace
(keyboard-translate ?\C-h ?\C-?)

;; assign help command
(global-set-key (kbd "C-x ?") 'help-command)

;; new prefix key
(defvar my-original-map (make-sparse-keymap) "My original keymap binded to C-j.")
(defalias 'my-original-prefix my-original-map)
(define-key global-map (kbd "C-j") 'my-original-prefix)

;; popup select window
(global-set-key (kbd "C-x o") 'popup-select-window)
(setq popup-select-window-popup-windows 3)

;; helm
(add-to-list 'load-path "~/.emacs.d/helm")
(require 'helm-config)
(define-key my-original-map (kbd "x") 'helm-M-x)
(define-key my-original-map (kbd "f") 'helm-find-file)
(define-key my-original-map (kbd "h") 'helm-mini)
(define-key my-original-map (kbd "d") 'helm-descbinds)
(define-key my-original-map (kbd "y") 'helm-show-kill-ring)

;; color theme
;;(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/emacs-color-theme-solarized")
;;(load-theme 'solarized-dark 0)

;; ;; haskell mode
;; (autoload 'haskell-mode "haskell-mode")
;; (autoload 'haskell-cabal "haskell-cabal")
;; (add-to-list 'auto-mode-alist '("\\.hs$" . haskell-mode))
;; (add-to-list 'interpreter-mode-alist '("runghc" . haskell-mode))
;; (add-to-list 'interpreter-mode-alist '("runhaskell" . haskell-mode))
;; (setq haskell-program-name "/usr/bin/ghci")

;; ;; ghc-mod
;; (add-to-list 'exec-path (concat (getenv "HOME") "/.cabal/bin"))
;; (add-to-list 'load-path "~/.cabal/share/ghc-mod-3.1.3")
;; (autoload 'ghc-init "ghc")
;; (ghc-init)
;; (add-to-list 'ac-sources 'ac-source-ghc-mod)
