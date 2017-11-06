(electric-indent-mode -1)

;;
;;add melpa
;;
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
;;(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

(add-to-list 'load-path "~/.emacs.d/lisp")

(when load-file-name
  (setq user-emacs-directory (file-name-directory load-file-name)))

;;
;;カラー設定
;;
;;applied hober color-theme
;; (add-to-list 'custom-theme-load-path
;; 	     (file-name-as-directory "~/dotfiles/emacs.d/elisp/themes/"))
;; (load-theme 'hober t)
;; (enable-theme 'hober)
;;(load-theme 'wombat t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(safe-local-variable-values (quote ((encoding . utf-8)))))
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

;;
;;透過の設定
;;
;; (when window-system
;;   (progn
;;     (setq default-frame-alist
;;       (append
;;        (list
;;         '(vertical-scroll-bars . nil) ;;スクロールバーはいらない
;;         '(alpha  . 85))
;;        default-frame-alist))))

;;(set-frame-parameter (selected-frame) 'alpha '(0.85))
;;(set-frame-parameter nil 'alpha 85)
;;(add-to-list 'default-frame-alist' (alpha . 85))

;;起動時にウィンドウを最大化する
;;(set-frame-parameter nil 'fullscreen 'maximized)

;;backup の保存先
(setq backup-directory-alist
  (cons (cons ".*" (expand-file-name "~/.emacs.d/backup/"))
        backup-directory-alist))

;;auto-save-fileの保存先
(setq auto-save-file-name-transforms
  `((".*", (expand-file-name "~/.emacs.d/backup/") t)))

;;スペースを色付け
(setq-default show-trailing-whitespace t)

;;指定した行数に飛ぶ
(global-set-key "\C-x\C-g" 'goto-line)

;;C-2などでウインドウを分割したときに、ウインドウの大きさを変更する
(defun window-resizer ()
  "Control window size and position."
  (interactive)
  (let ((window-obj (selected-window))
        (current-width (window-width))
        (current-height (window-height))
        (dx (if (= (nth 0 (window-edges)) 0) 1
              -1))
        (dy (if (= (nth 1 (window-edges)) 0) 1
              -1))
        action c)
    (catch 'end-flag
      (while t
        (setq action
              (read-key-sequence-vector (format "size[%dx%d]"
                                                (window-width)
                                                (window-height))))
        (setq c (aref action 0))
        (cond ((= c ?f)
               (enlarge-window-horizontally dx))
              ((= c ?b)
               (shrink-window-horizontally dx))
              ((= c ?n)
               (enlarge-window dy))
              ((= c ?p)
               (shrink-window dy))
              ;; otherwise
              (t
               (let ((last-command-char (aref action 0))
                     (command (key-binding action)))
                 (when command
                   (call-interactively command)))
               (message "Quit")
               (throw 'end-flag t)))))))
(global-set-key "\C-c\C-s" 'window-resizer)

;; (setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
;; (setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
;; (setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse

(defun mouse-scroll-down ()
  (interactive)
  (scroll-down 1))
(defun mouse-scroll-up ()
  (interactive)
  (scroll-up 1))

(global-set-key [wheel-up] 'mouse-scroll-down)
(global-set-key [wheel-down] 'mouse-scroll-up)

;; C-kでもクリップボードにコピーする
(cond (window-system
  (setq x-select-enable-clipboard t)
  (setq x-select-enable-primary t)
;;  (define-key global-map "\M-w" 'clipboard-kill-ring-save)
;;  (define-key global-map "\C-w" 'clipboard-kill-region)
;;  (define-key global-map "\C-y" 'clipboard-yank)
))

(add-to-list 'default-frame-alist '(font . "Ricty Diminished"))

;; (set-face-attribute 'default nil
;;                    :family "Ricty"
;;                    :height 160)
;; (set-fontset-font
;;  nil 'japanese-jisx0208
;;  (font-spec :family "Ricty"))

;; (set-face-attribute 'default nil
;;                     :family "Ricty Diminished Discord"
;;                     :height 110)
;; (set-fontset-font (frame-parameter nil 'font)
;;                   'japanese-jisx0208
;;                   (cons "Ricty Diminished Discord" "iso10646-1"))
;; (set-fontset-font (frame-parameter nil 'font)
;;                   'japanese-jisx0212
;;                   (cons "Ricty Diminished Discord" "iso10646-1"))
;; (set-fontset-font (frame-parameter nil 'font)
;;                   'katakana-jisx0201
;;                   (cons "Ricty Diminished Discord" "iso10646-1"))

;;
;; Auto Complete
;;
(require 'auto-complete-config)
(ac-config-default)
(add-to-list 'ac-modes 'text-mode)         ;; text-modeでも自動的に有効にする
(add-to-list 'ac-modes 'fundamental-mode)  ;; fundamental-mode
(add-to-list 'ac-modes 'org-mode)
(add-to-list 'ac-modes 'yatex-mode)
(ac-set-trigger-key "TAB")
(setq ac-use-menu-map t)       ;; 補完メニュー表示時にC-n/C-pで補完候補選択
(setq ac-use-fuzzy t)          ;; 曖昧マッチ

;;
;; el-get.el
;;
;;get el-get.el
(add-to-list 'load-path (locate-user-emacs-file "el-get/el-get"))
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))


;; ;; load-path で ~/.emacs.d とか書かなくてよくなる
;; (when load-file-name
;;   (setq user-emacs-directory (file-name-directory load-file-name)))

;; ;; el-get
;; (add-to-list 'load-path (locate-user-emacs-file "el-get/el-get"))
;; (require 'el-get)
;; ;; el-getでダウンロードしたパッケージは ~/.emacs.d/ に入るようにする
;; (setq el-get-dir (locate-user-emacs-file "el-get"))

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

(global-linum-mode t)

(global-set-key (kbd "M-n") (lambda () (interactive) (scroll-up 1)))
(global-set-key (kbd "M-p") (lambda () (interactive) (scroll-down 1)))

(delete-selection-mode t)

;;分割したウインドウ移動
(global-set-key (kbd "C-x n")  'windmove-down)
(global-set-key (kbd "C-x p")  'windmove-up)
(global-set-key (kbd "C-x f")  'windmove-right)
(global-set-key (kbd "C-x b")  'windmove-left)

;; neotree
(require 'neotree)
;; 隠しファイルをデフォルトで表示
(setq neo-show-hidden-files t)
;; cotrol + q でneotreeを起動
(global-set-key "\C-q" 'neotree-toggle)
(setq neo-theme (if (display-graphic-p) 'icons 'arrow))
