(setq custom-file "~/.emacs.d/custom-file.el")
(load-file "~/.emacs.d/custom-file.el")

(load-theme 'zerodark)

(tool-bar-mode -1)
(menu-bar-mode 1)
(scroll-bar-mode 1)
(global-hl-line-mode t)
(global-display-line-numbers-mode 1)
(line-number-mode t)
(column-number-mode t)


;;
;; Programming languages
;;

(use-package haskell-mode
  :config
  (require 'haskell-interactive-mode)
  (require 'haskell-process)
  (add-hook 'haskell-mode-hook 'interactive-haskell-mode))


;;
;; Projects
;;

(use-package projectile
  :ensure t
  :config
  (projectile-mode +1)
  (setq projectile-completion-system 'default)  ; Don't use ido (use selectrum instead)
  :bind-keymap (("C-c p" . 'projectile-command-map)
		("s-p"   . 'projectile-command-map)))


(use-package magit
  :ensure t
  :bind ("C-x g" . magit-status))

;;
;; Completion framework
;;

;; (use-package helm
;;   :ensure t
;;   :config (helm-mode 1))

;; (use-package ivy
;;   :ensure t
;;   :config
;;   (ivy-mode 1)
;;   (setq ivy-use-virtual-buffers t)
;;   (setq enable-recursive-minibuffers t))

(use-package selectrum
  :ensure t
  :init
  ; <copy-pasta>
  (let ((class '((class color) (min-colors 89))))
  (custom-theme-set-faces
   'zerodark
   `(selectrum-current-candidate
     ((,class (:background "#48384c"
                           :weight bold
                           :foreground "#c678dd"))))
   `(selectrum-primary-highlight ((,class (:foreground "#da8548"))))
   `(selectrum-secondary-highlight ((,class (:foreground "#98be65"))))))
  ; </copy-pasta>
  :config
  (selectrum-mode +1))

(use-package selectrum-prescient
  :ensure t
  :config
  (selectrum-prescient-mode +1)
  (prescient-persist-mode +1))

(use-package mini-frame
  :ensure t
  :init
  (setq resize-mini-frames t)
  (setq mini-frame-show-parameters
   '((top . 10)
     (width . 0.7)
     (left . 0.5)))
  :config
  (mini-frame-mode))

(use-package all-the-icons
  :ensure t)

(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-center-content t
	))

(use-package company
  ;; Navigate in completion minibuffer with `C-n` and `C-p`.
  :bind (:map company-active-map
         ("C-n" . company-select-next)
         ("C-p" . company-select-previous))
  :config
  ;; Provide instant autocompletion
  (setq company-idle-delay 0.2)

  ;; Use company mode everywhere.
  (global-company-mode t))

;; Recent buffers in a new Emacs session
(use-package recentf
  :config
  (setq recentf-auto-cleanup 'never
        recentf-max-saved-items 1000
        recentf-save-file (concat user-emacs-directory ".recentf"))
  (recentf-mode t)
  :diminish nil)

(use-package zim-wiki-mode
; :load-path "~/path/to/zim-wiki-mode.el" ; if using dev branch, otherwise no need
  :bind ("C-c C-n" . zim-wiki-goto-now)
  :init
    (add-hook 'zim-wiki-mode-hook 'flyspell-mode)
  :config
    ; if not set, would use projectile directory
    (setq zim-wiki-always-root "c:/Users/diogotito/Todo_txt/zimwiki/") 
;   (setq zim-wiki-journal-datestr "Calendar/%Y/%02m.txt")
    (evil-leader/set-key-for-mode 'zim-wiki-mode "z" 'zim-wiki-hydra/body)
    )
(put 'narrow-to-region 'disabled nil)
