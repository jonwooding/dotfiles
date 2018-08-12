(require 'package)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages"))

;; (setq package-enable-at-startup nil)
(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t)
 '(initial-buffer-choice "D:/")
 '(package-selected-packages
   (quote
    (evil evil-escape evil-surround company vlf highlight-indent-guides highlight-parentheses)))
 '(safe-local-variable-values
   (quote
    ((eval when
           (fboundp
            (quote rainbowmode))
           (rainbow mode 1)))))
 '(tool-bar-mode nil)
 '(uniquify-buffer-name-style (quote post-forward) nil (uniquify)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(icomplete-first-match ((t (:foreground "firebrick" :weight bold)))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; General settings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq-default scroll-down-aggressively 0.05)
(setq-default scroll-up-aggressively 0.05)
(setq-default scroll-error-top-bottom nil)
(setq-default tab-always-indent nil)
(setq-default backward-delete-char-untabify-method 'hungry)
;; Clean up autosave files
(setq backup-directory-alist `(("." . "~/.saves")))
(setq backup-by-copying t)
;; Auto close parens etc.
(electric-pair-mode 1)
(electric-layout-mode nil)
;; Highlight current line and add line nums
(global-hl-line-mode t)
(global-linum-mode t)
;; icomplete settings
(icomplete-mode t)
(setq-default icomplete-prospects-height 4)
(setq-default icomplete-separator "   ")
(setq-default icomplete-show-matches-on-no-input t)
;; Set default window size
(add-to-list 'default-frame-alist '(left . 0))
(add-to-list 'default-frame-alist '(top . 0))
(add-to-list 'default-frame-alist '(height . 62))
(add-to-list 'default-frame-alist '(width . 125))

;; Get rid of annoying stuff
(menu-bar-mode -1)
(menu-bar-showhide-tool-bar-menu-customize-disable)

;; Stupid bell thing
(setq-default ring-bell-function 'ignore)

;; C style guide
(require 'cc-mode)
(setq c-default-style "bsd")
(setq-default c-basic-offset 4
              tab-width 4
              indent-tabs-mode nil
              fill-column 80)

;; extending formatting to other modes
;; (add-to-list 'auto-mode-alist '("\\.mode\\'" . python-mode))

;; GDB
(setq gdb-many-windows 't)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Evil and Evil plugins
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'evil)
(evil-mode t)

;; fix :W :Q :E
(with-eval-after-load 'evil-ex
  (evil-ex-define-cmd "W[rite]" 'evil-write)
  (evil-ex-define-cmd "E[dit]" 'evil-edit)
  (evil-ex-define-cmd "Q[uit]" 'evil-quit))

;; Stop Emacs from being Emacs
(setq evil-emacs-state-modes (delq 'ibuffer-mode evil-emacs-state-modes))

;; commenting in Evil mode
(define-key evil-normal-state-map "-" 'comment-line)
(define-key evil-visual-state-map "-" 'comment-or-uncomment-region)
;; (define-key evil-visual-state-map "I" 'string-insert-rectangle)

;; Helper function to update when changing windows
(defun jcw-evil-update-mode-line ()
  (pcase evil-state
    ('normal (set-face-background 'mode-line "#994e12"))
    ('insert (set-face-background 'mode-line "#870000"))
    ('visual (set-face-background 'mode-line "#5f8787"))
    ('replace (set-face-background 'mode-line "#dark magenta"))
    ('motion (set-face-background 'mode-line "#black"))
    ('emacs (set-face-background 'mode-line "#gainsboro"))))

;; For windows opened with focus maintained on current window
(add-hook 'window-configuration-change-hook 'jcw-evil-update-mode-line)
;; For switching windows with different evil-states
(add-hook 'buffer-list-update-hook 'jcw-evil-update-mode-line)
;; Handling evil-state-changes
(add-hook 'evil-emacs-state-entry-hook 'jcw-evil-update-mode-line)
(add-hook 'evil-motion-state-entry-hook 'jcw-evil-update-mode-line)
(add-hook 'evil-replace-state-entry-hook 'jcw-evil-update-mode-line)
(add-hook 'evil-visual-state-entry-hook 'jcw-evil-update-mode-line)
(add-hook 'evil-insert-state-entry-hook 'jcw-evil-update-mode-line)
(add-hook 'evil-normal-state-entry-hook 'jcw-evil-update-mode-line)
;; Note: missing modes, should be expanded some day (TM)

;; Use jk key-chord to return to evil-normal-state
(require 'evil-escape)
(evil-escape-mode t)
(setq-default evil-escape-key-sequence "jk")
(setq-default evil-escape-unordered-key-sequence t)
(setq-default evil-escape-delay 0.08)

;; Surround stuff with other stuff
(require 'evil-surround)
(evil-surround-mode t)
(global-evil-surround-mode 1)
(setq-default evil-surround-pairs-alist
   (quote
    ((40 "(" . ")")
     (91 "[" . "]")
     (123 "{" . "}")
     (41 "(" . ")")
     (93 "[" . "]")
     (125 "{" . "}")
     (35 "#{" . "}")
     (98 "(" . ")")
     (66 "{" . "}")
     (62 "<" . ">")
     (116 . evil-surround-read-tag)
     (60 . evil-surround-read-tag)
     (102 . evil-surround-function))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Appearance
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Load in a tasty theme
(require 'gruvbox-theme)
(load-theme 'gruvbox t)

(setq hl-paren-background-colors (quote ("dark red" "indian red" "magenta4" "OliveDrab4")))
(setq-default hl-paren-colors nil)

;; Highlight matching braces/parens
(require 'highlight-parentheses)
(define-globalized-minor-mode global-highlight-parentheses-mode
  highlight-parentheses-mode
  (lambda nil (highlight-parentheses-mode t)))
(global-highlight-parentheses-mode t)

;; Highlight indentations
(require 'highlight-indent-guides)
(add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
(setq highlight-indent-guides-method 'character)

;; Limit $PWD length to last ## chars
(setq-default max-directory-length 30)
(defun trim-default-directory ()
  (if (< max-directory-length (length default-directory))
      (substring default-directory (- max-directory-length))
    default-directory))

;; Mode-line format
(setq-default mode-line-format
              (list " "
                    'system-name
                    "%@:"
                    '(:eval (trim-default-directory))
                    'mode-line-buffer-identification
                    'mode-line-modified
                    "  [%l, %c] "
                    `(vc-mode vc-mode)
                    )
              )

;; Mode-line appearance (color ovrode by evil mode line)
(set-face-attribute 'mode-line
                    nil
                    :background "#994e12"
                    :box '(:line-width 1 :style released-button))

;; Show $PWD in title bar
(setq frame-title-format
      '(buffer-file-name "%b - %f"
                         (dired-directory dired-directory
                                          revert-buffer-function "%b"
                                          ("%b - Dir: "
                                           default-directory))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Company mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-hook 'after-init-hook 'global-company-mode)
;; allow typing after partial completion
(setq-default company-require-match nil)
(setq-default company-backends
              (quote((company-dabbrev-code company-dabbrev company-elisp))))
(setq-default company-dabbrev-code-everywhere t)
(setq-default company-idle-delay 0)

(defun move-text-internal (arg)
   (cond
    ((and mark-active transient-mark-mode)
     (if (> (point) (mark))
            (exchange-point-and-mark))
     (let ((column (current-column))
              (text (delete-and-extract-region (point) (mark))))
       (forward-line arg)
       (move-to-column column t)
       (set-mark (point))
       (insert text)
       (exchange-point-and-mark)
       (setq deactivate-mark nil)))
    (t
     (beginning-of-line)
     (when (or (> arg 0) (not (bobp)))
       (forward-line)
       (when (or (< arg 0) (not (eobp)))
            (transpose-lines arg))
       (forward-line -1)))))

(defun move-text-down (arg)
   "Move region (transient-mark-mode active) or current line
  arg lines down."
   (interactive "*p")
   (move-text-internal arg))

(defun move-text-up (arg)
   "Move region (transient-mark-mode active) or current line
  arg lines up."
   (interactive "*p")
   (move-text-internal (- arg)))

;; (defun move-text-internal (arg)
  ;; (cond
   ;; ((and mark-active transient-mark-mode)
        ;; (if (> (point) (mark))
            ;; (exchange-point-and-mark))
        ;; (let ((column (current-column))
              ;; (text (delete-and-extract-region (point) (mark))))
          ;; (forward-line arg)
          ;; (move-to-column column t)
          ;; (set-mark (point))
          ;; (insert text)
          ;; (exchange-point-and-mark)
          ;; (setq deactivate-mark nil)))
       ;; (t
        ;; (beginning-of-line)
        ;; (when (or (> arg 0) (not (bobp)))
          ;; (forward-line)
          ;; (when (or (< arg 0) (not (eobp)))
            ;; (transpose-lines arg))
          ;; (forward-line -1))))
  ;; (evil-indent-line (point) (mark)))

;; (defun move-text-down (arg)
  ;; (interactive "*p")
  ;; (move-text-internal (arg)))

;; (defun move-text-up (arg)
  ;; (interactive "*p")
  ;; (move-text-internal (- arg)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Utility functions (gdb and stuff skipped)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; M-p to tag a buffer for swapping, second usage swaps buffers
(setq swapping-buffer nil)
(setq swapping-window nil)
(defun swap-buffers-in-windows ()
  "Swap buffers between two windows"
  (interactive)
  (if (and swapping-window swapping-buffer)
      (let ((this-buffer (current-buffer))
            (this-window (selected-window)))
        (if (and (window-live-p swapping-window)
                 (buffer-live-p swapping-buffer))
            (progn (switch-to-buffer swapping-buffer)
                   (select-window swapping-window)
                   (switch-to-buffer this-buffer)
                   (select-window this-window)
                   (message "Swapped buffers"))
          (message "Old buffer/window killed. Aborting"))
        (setq swapping-buffer nil)
        (setq swapping-window nil))
  (progn
    (setq swapping-buffer (current-buffer))
    (setq swapping-window (selected-window))
    (message "Buffer and window marked for swapping"))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Keybindings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define-key c-mode-base-map (kbd "RET") 'newline-and-indent)
(define-key c-mode-base-map (kbd "TAB") 'tab-to-tab-stop)
(define-key evil-normal-state-map (kbd "C-o") 'newline-and-indent)
(global-set-key (kbd "C-k") 'move-text-up)
(global-set-key (kbd "C-j") 'move-text-down)
(global-set-key (kbd "<M-up>") 'evil-window-up)
(global-set-key (kbd "<M-down>") 'evil-window-down)
(global-set-key (kbd "<M-left>") 'evil-window-left)
(global-set-key (kbd "<M-right>") 'evil-window-right)
(global-set-key (kbd "M-O") 'previous-multiframe-window)
(global-set-key (kbd "M-o") 'other-window)
(global-set-key (kbd "M-0") 'delete-window)
(global-set-key (kbd "M-1") 'delete-other-windows)
(global-set-key (kbd "M-2") 'split-window-vertically)
(global-set-key (kbd "M-3") 'split-window-horizontally)
(global-set-key (kbd "M-i") 'ibuffer)
(global-set-key (kbd "M-p") 'swap-buffers-in-windows)
(global-unset-key (kbd "<C-next>"))
(global-unset-key (kbd "<C-prior>"))

