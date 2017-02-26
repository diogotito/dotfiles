
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(require 'haskell-interactive-mode)
(require 'haskell-process)
(add-hook 'haskell-mode-hook 'interactive-haskell-mode)



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(custom-enabled-themes (quote (wombat)))
 '(haskell-mode-hook
   (quote
    (haskell-decl-scan-mode haskell-indentation-mode highlight-uses-mode imenu-add-menubar-index interactive-haskell-mode turn-on-haskell-unicode-input-method)))
 '(inhibit-startup-screen t)
 '(initial-scratch-message nil)
 '(package-archives
   (quote
    (("melpa" . "https://melpa.org/packages/")
     ("gnu" . "http://elpa.gnu.org/packages/"))))
 '(package-selected-packages
   (quote
    (evil evil-args evil-commentary evil-easymotion evil-ediff evil-escape evil-exchange evil-god-state evil-leader evil-mark-replace evil-matchit evil-mc evil-mc-extras evil-numbers evil-org evil-paredit evil-quickscope evil-replace-with-register evil-rsi evil-smartparens evil-snipe evil-space evil-surround evil-swap-keys evil-tabs evil-terminal-cursor-changer evil-vimish-fold evil-visual-mark-mode evil-visual-replace evil-visualstar company-ghc company-go company-shell company-web haskell-mode haskell-snippets)))
 '(tool-bar-mode nil)
 '(tool-bar-style (quote text)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'scroll-left 'disabled nil)
