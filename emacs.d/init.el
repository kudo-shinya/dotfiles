(electric-indent-mode -1)

;;add melpa
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
;;(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

(add-to-list 'load-path "~/.emacs.d/lisp")

(when load-file-name
  (setq user-emacs-directory (file-name-directory load-file-name)))

;;
;; Auto Complete
;;
;;(require 'auto-complete-config)
;;(ac-config-default)
;;(add-to-list 'ac-modes 'text-mode)         ;; text-modeでも自動的に有効にする
;;(add-to-list 'ac-modes 'fundamental-mode)  ;; fundamental-mode
;;(add-to-list 'ac-modes 'org-mode)
;;(add-to-list 'ac-modes 'yatex-mode)
;;(ac-set-trigger-key "TAB")
;;(setq ac-use-menu-map t)       ;; 補完メニュー表示時にC-n/C-pで補完候補選択
;;(setq ac-use-fuzzy t)          ;; 曖昧マッチ

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(button ((t (:inherit link))))
 '(custom-comment-tag ((t (:foreground "magenta"))))
 '(custom-group-tag ((t (:inherit variable-pitch :foreground "magenta" :weight bold :height 1.2))))
 '(custom-variable-tag ((t (:foreground "yellow" :weight bold))))
 '(font-lock-builtin-face ((t (:foreground "red" :weight bold))))
 '(font-lock-comment-face ((t (:foreground "red"))))
 '(font-lock-function-name-face ((t (:foreground "yellow" :weight bold))))
 '(fringe ((t (:background "red"))))
 '(link ((t (:foreground "cyan" :underline t))))
 '(minibuffer-prompt ((t (:foreground "green"))))
 '(tool-bar ((t (:foreground "magenta" :box (:line-width 1 :style released-button))))))

;;applied hober color-theme
;; (add-to-list 'custom-theme-load-path
;; 	     (file-name-as-directory "~/dotfiles/emacs.d/elisp/themes/"))
;; (load-theme 'hober t)
;; (enable-theme 'hober)
;;(load-theme 'wombat t)

;; フレームの透明度
(set-frame-parameter (selected-frame) 'alpha '(0.85))

;; backup の保存先
(setq backup-directory-alist
  (cons (cons ".*" (expand-file-name "~/.emacs.d/backup/"))
        backup-directory-alist))

(setq auto-save-file-name-transforms
  `((".*", (expand-file-name "~/.emacs.d/backup/") t)))

;; get el-get.el
(add-to-list 'load-path (locate-user-emacs-file "el-get/el-get"))
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

;;(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")
;;(el-get 'sync)

;; (el-get 'sync
;;   'color-moccur
;;   'magit
;; )

;; load in ~/.emacs.d/inits
(el-get-bundle tarao/with-eval-after-load-feature-el
  (require 'init-loader)
  (setq init-loader-show-log-after-init nil)
  (init-loader-load "~/.emacs.d/inits")
  (if (not (equal (init-loader-error-log) ""))
      (init-loader-show-log))
)

;;スペースを色付け
(setq-default show-trailing-whitespace t)

;;指定した行数に飛ぶ
(global-set-key "\C-x\C-g" 'goto-line)
