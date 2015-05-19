(if (file-exists-p "~/.header.el")
    (load-file "~/.header.el"))
;; (if (file-exists-p "~/.auto-header.el")
;;     (load-file "~/.auto-header.el"))

;;C-x z
;; M-x M-%
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(blink-cursor-mode nil)
 '(column-number-mode t)
 '(display-battery-mode t)
 '(display-time-mode t)
 '(indicate-empty-lines t)
 '(show-paren-mode t)
 '(size-indication-mode t)
 '(text-mode-hook (quote (turn-on-auto-fill text-mode-hook-identify))))
 '(load-library "paren")
 '(show-paren-mode 1)
 '(make-face 'paren)
 '(setq show-paren-face 'paren)
 '(size-indication-mode t)

;;you just have to type y or n instead of yes and no
(fset 'yes-or-no-p 'y-or-n-p)

;; errase all kind of space at the end of line
(defun delete-trailing-spaces ()
  "delete all spaces, tab at the end of each line"
  (interactive)
  (progn
    (save-excursion
      (goto-line 1)
      (replace-regexp "[ \t]+$" "")
      )
    )
  )

;; remove all spaces at the end of each file while saving
(add-hook 'fsharp-mode-hook '(lambda ()
  (add-hook 'write-contents-hooks 'delete-trailing-whitespace nil t)))
(add-hook 'c++-mode-hook '(lambda ()
  (add-hook 'write-contents-hooks 'delete-trailing-whitespace nil t)))
(add-hook 'java-mode-hook '(lambda ()
  (add-hook 'write-contents-hooks 'delete-trailing-whitespace nil t)))
(add-hook 'makefile-mode '(lambda ()
  (add-hook 'write-contents-hooks 'delete-trailing-whitespace nil t)))
(add-hook   'c-mode-hook '(lambda ()
  (add-hook 'write-contents-hooks 'delete-trailing-whitespace nil t)))
(add-hook   'sh-mode '(lambda ()
  (add-hook 'write-contents-hooks 'delete-trailing-whitespace nil t)))
(add-hook   'lisp-mode '(lambda ()
  (add-hook 'write-contents-hooks 'delete-trailing-whitespace nil t)))
(add-hook   'pyton-mode '(lambda ()
  (add-hook 'write-contents-hooks 'delete-trailing-whitespace nil t)))

;; (glasses-mode -1)
;; (setq glasses-separator "~")


;; show all space a the end of each file
(setq-default show-trailing-whitespace t)

(add-hook 'term-mode-hook '(lambda ()
			     (setq show-trailing-whitespace nil)))

;; Autoinsert permet de gerer des templates pour chaque type de fichier
;; edite.
;(add-hook 'find-file-hooks 'auto-insert)
;(setq auto-insert-directory (expand-file-name "~/emacs-lisp/autoinsert/"))
;(define-auto-insert "\\.pl\\'" '"template.pl")
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "black" :foreground "seashell" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 100 :width normal)))))

(set-cursor-color "blue")

(define-key global-map (kbd "RET") 'newline-and-indent)

(global-unset-key [insertchar])
(global-set-key [f5] 'compile)
(global-set-key [f4] 'c++-mode)
(global-set-key [f3] 'delete-trailing-spaces)
(global-set-key [f1] (lambda () (interactive) (manual-entry (current-word))))


(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(blink-cursor-mode -1)
(setq inhibit-startup-message t
      initial-scratch-message nil)

(fset 'shell '(lambda ()(interactive)(ansi-term "/bin/zsh")))

(if (window-system)
    (set-frame-height (selected-frame) 300))

(if (window-system)
    (set-frame-width (selected-frame) 300))

;; (if (file-exists-p "~/.sl-speedbar.el")
;;     (load-file "~/.sl-speedbar.el"))

;; (if (window-system)
;;     (sr-speedbar-toggle)
;;   (sr-speedbar-open)
;;   )

(setq load-path (cons "~/.emacs.d/fsharp" load-path))
(setq auto-mode-alist (cons '("\\.fs[iylx]?$" . fsharp-mode) auto-mode-alist))
(autoload 'fsharp-mode "fsharp" "Major mode for editing F# code." t)
(autoload 'run-fsharp "inf-fsharp" "Run an inferior F# process." t)

;; (speedbar-add-supported-extension ".fs")
;; (add-to-list 'speedbar-fetch-etags-parse-list
;; 	     '("\\.fs" . speedbar-parse-mltag))


;;(set-frame-name "WORK")
(split-window)

(defun duplicate-line()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (open-line 1)
  (next-line 1)
  (yank)

  )
(global-set-key (kbd "C-d") 'duplicate-line)
(shell)

;; (defmethod eieio-speedbar-object-children ((this ede-target))
;;   "Return the list of speedbar display children for THIS."
;;   (sort (oref this source) 'string<))


;; Skeleton des headers protege
(define-skeleton insert-protect-header-c
  "Inserts a define to protect the header file."
  ""
  '(setq str (file-name-sans-extension
          (file-name-nondirectory (buffer-file-name))))
  "#ifndef		"(upcase str)"_H_\n"
  "# define	"(upcase str)"_H_\n"
  "\n"
  "#endif		/* !"(upcase str)"_H_ */\n")

(define-skeleton insert-protect-header-cpp
  "Inserts a define to protect the header file."
  ""
  '(setq str (file-name-sans-extension
          (file-name-nondirectory (buffer-file-name))))
  "#ifndef		"(upcase str)"_HH_\n"
  "# define	"(upcase str)"_HH_\n"
  "\n"
  "class " str "\n"
  "{\n"
  "public:\n"
  "  " str "(void);\n"
  "  ~" str "(void);\n"
  "\n"
  "private:\n"
  "  " str "(const " str "& Other);\n"
  "  " str "		&operator=(const " str "& Other);\n"
  "};\n"
  "\n"
  "#endif		// !"(upcase str)"_HH_\n")


(define-skeleton insert-header-c
  "Inserts the include corresponding to the file"
  ""
  '(setq str (file-name-sans-extension
          (file-name-nondirectory (buffer-file-name))))
  "#include \"" str ".h\"\n")

(define-skeleton insert-header-cpp
  "Inserts the include corresponding to the file"
  ""
  '(setq str (file-name-sans-extension
          (file-name-nondirectory (buffer-file-name))))
  "#include \"" str ".hh\"\n")

(define-skeleton create-makefile
  "Create the skeleton of a makefile"
  ""
  "NAME	= test\n"
  "SRCDIR	= ./sources\n"
  "INCDIR	= ./includes\n"
  "OBJDIR	= ./objects\n"
  "SRCSC	= $(wildcard $(SRCDIR)/*.c)\n"
  "SRCSCXX	= $(wildcard $(SRCDIR)/*.cpp)\n"
  "LIBS	=\n"
  "\n"
  "\n"
  "CC	= @gcc\n"
  "CXX	= @g++\n"
  "RM	= @rm -f\n"
  "ECHO	= @echo\n"
  "\n"
  "\n"
  "CFLAGS	= -pipe -Wall -Wextra -g -O0 -Werror -ansi -pedantic -MMD -std=c99 -I $(INCDIR) -fdiagnostics-color=always\n"
  "CXXFLAGS	= -pipe -Wall -Wextra -g -O0 -Werror -ansi -pedantic -MMD -std=c++11 -I $(INCDIR) -fdiagnostics-color=always\n"
  "LDFLAGS	=\n"
  "\n"
  "OBJSC	= $(SRCSC:.c=.o)\n"
  "OBJSCXX	= $(SRCSCXX:.cpp=.o)\n"
  "OBJS	= $(OBJSC) $(OBJSCXX)\n"
  "OBJS := $(notdir $(OBJS))\n"
  "OBJS	:= $(addprefix $(OBJDIR)/, $(OBJS))\n"
  "DEPS	= $(OBJS:.o=.d)\n"
  "\n"
  "\n"
  "$(NAME): $(OBJS)\n"
  "	$(ECHO) \"Creating $(NAME)\"\n"
  "	$(CC) $(OBJS) -o $(NAME) $(LIBS) $(LDFLAGS) $(CFLAGS) $(CXXFLAGS)\n"
  "\n"
  "all:	$(NAME)\n"
  "\n"
  "$(OBJDIR)/%.o: $(SRCDIR)/%.c\n"
  "	$(ECHO) \"Compilling $< ...\"\n"
  "	$(CC) -c $(CFLAGS) $< -o $@\n"
  "\n"
  "$(OBJDIR)/%.o: $(SRCDIR)/%.cpp\n"
  "	$(ECHO) \"Compilling $< ...\"\n"
  "	$(CXX) -c $(CXXFLAGS) $< -o $@\n"
  "\n"
  "clean:\n"
  "	$(RM) $(OBJS)\n"
  "	$(RM) $(wildcard *~)\n"
  "	$(RM) $(DEPS)\n"
  "\n"
  "fclean: clean\n"
  "	$(RM) $(NAME)\n"
  "\n"
  "re: fclean all\n"
  "\n"
  "-include $(DEPS)\n"
  )

(define-skeleton create-main-c-or-cpp
  "Create a main for C and C++"
  ""
  '(setq str (file-name-sans-extension
          (file-name-nondirectory (buffer-file-name))))
  "int		main(int ac, char **av)\n"
  "{\n"
  "  (void)ac;\n"
  "  (void)av;\n"
  "  return (0);\n"
  "}\n"
  )

(add-hook 'find-file-hook
	  (lambda()
	    (if (= (buffer-size) 0)
		(cond  ((string-match "main.c$" (buffer-file-name)) (create-main-c-or-cpp))
		       ((string-match "main.cpp$" (buffer-file-name)) (create-main-c-or-cpp))
		       ((string-match "\\.h$" (buffer-file-name)) (insert-protect-header-c))
		       ((string-match "\\.hh$" (buffer-file-name)) (insert-protect-header-cpp))
		       ((string-match "\\.c$" (buffer-file-name)) (insert-header-c))
		       ((string-match "\\.cpp$" (buffer-file-name)) (insert-header-cpp))
		       ((string-match "\\Makefile$" (buffer-file-name)) (create-makefile))
		       ))))



(setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
  backup-by-copying t    ; Don't delink hardlinks
  version-control t      ; Use version numbers on backups
  delete-old-versions t  ; Automatically delete excess backups
  kept-new-versions 20   ; how many of the newest versions to keep
  kept-old-versions 5    ; and how many of the old
  )
