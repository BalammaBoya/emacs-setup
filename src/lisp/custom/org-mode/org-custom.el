;;; Org mode customizations for Venkatesh

(print "begin Venkatesh org-custom.el")
(print "begin Venkatesh org-custom.el")
(print "begin Venkatesh org-custom.el")


(require 'org-agenda-custom)

;;; ido mode
;;; disable ido.  +ve number enables it.
;; (ido-everywhere 0)

;;; tags
;;; ====

;;; Keep this line commented if you want to use buffer-specific tags.
;;; (setq org-tag-alist nil)
;;; (setq org-fast-tag-selection-single-key nil)

(setq todo-only nil)
(autoload 'org-calculate-tag-time "sacha")

;;; journal
;;; =======

;;; (require 'org-id)

;;; Refereces and Citations
;;; =======================

;;; see
;;; https://github.com/jkitchin/org-ref
;;; http://kitchingroup.cheme.cmu.edu/blog/2014/05/13/Using-org-ref-for-citations-and-references/
(autoload 'helm-bibtex "helm-bibtex" "" t)
(require 'org-ref)
(require 'helm-bibtex)
(require 'doi-utils)
(require 'org-ref-pdf)
(require 'org-ref-url-utils)
(require 'org-ref-bibtex)
(require 'org-ref-latex)
(require 'org-ref-arxiv)
(require 'org-ref-pubmed)
(require 'org-ref-isbn)
(require 'org-ref-wos)
(require 'org-ref-scopus)
(require 'x2bib)
(require 'nist-webbook)



(setq reftex-default-bibliography '("~/venk/work/research/biblio/ref.bib"))

(setq
 org-ref-bibliography-notes "~/venk/work/research/biblio/notes.org"
 org-ref-default-bibliography '("~/venk/work/research/biblio/ref.bib")
 org-ref-pdf-directory "~/venk/work/research/biblio/pdfs/")

(setq bibtex-completion-bibliography "~/venk/work/research/biblio/ref.bib")
(setq bibtex-completion-library-path "~/venk/work/research/biblio/pdfs")
(setq bibtex-completion-notes-path  "~/venk/work/research/biblio/helm-bibtex-notes")

(setq bibtex-completion-pdf-open-function
  (lambda (fpath)
    (start-process "evince" "*evince*" "evince" fpath)))


;; (load "org-ref-custom.el")

;;; org-ref based BibTeX setup



;;; Reftex and BibTeX setup
;;; -----------------------
;;; http://article.gmane.org/gmane.emacs.orgmode/2406/match=bibliography
;;; (load "my-org-bib.el")

;;; Bib and Reftex customization

;;; (require 'my-org-bib)

;; (load-file "my-org-bib.el")

; Use IDO for both buffer and file completion and ido-everywhere to t

;; disabled choppell [2015-05-22 Sun]
;; (setq org-completion-use-ido t)
;; (setq ido-everywhere t)
;; (setq ido-max-directory-size 100000)
;; (ido-mode (quote both))

;;; Encrypting files
;;; ----------------
;;; http://emacs.wordpress.com/2008/07/18/keeping-your-secrets-secret/
;;; see http://yenliangl.blogspot.com/2009/12/encrypt-your-important-data-in-emacs.html
(require 'epa)


(epa-file-enable)

(require 'org-crypt)
(org-crypt-use-before-save-magic)
(setq org-tags-exclude-from-inheritance (quote ("crypt")))
;; (setq org-crypt-key "~/.ssh/venk-rsa")
(setq org-crypt-key "~/.gnupg/choppell@gmail.com.gpg")
;; GPG key to use for encryption
;; (setq org-crypt-key nil)
;; Either the Key ID or set to nil to use symmetric encryption.
     
;; (setq auto-save-default nil)
;; Auto-saving does not cooperate with org-crypt.el: so you need
;; to turn it off if you plan to use org-crypt.el quite often.
;; Otherwise, you'll get an (annoying) message each time you
;; start Org.
     
;; To turn it off only locally, you can insert this:
;;
;; # -*- buffer-auto-save-file-name: nil; -*-

;; active Babel languages
(org-babel-do-load-languages
  'org-babel-load-languages
   '(  

     (ditaa . t) ;; ditaa jar file comes with org-mode 8+
     (emacs-lisp . t)
     (js . t) 
     (latex . t)
     (python . t)
     (scheme . t)
     (sh . t)
	 ))

;;; For noweb.  From Thirumal
(setq org-babel-use-quick-and-dirty-noweb-expansion t)


(setq org-src-fontify-natively t)
(org-restart-font-lock)
;; get rid of the irritating confirmation box -> SECURITY WARNING!
(setq org-confirm-babel-evaluate nil)

;;; tangle code before publishing it.
(add-hook 'org-publish-after-export-hook 'org-babel-tangle 'append)

;;; disable evaluation during export
(setq org-export-babel-evaluate nil)

;;; Allow for emacs variables to become buffer-local during export by
;;; using the BIND keyword
(setq org-export-allow-bind-keywords t)
(setq org-export-html-postamble nil)
(setq org-export-html-preamble nil)

;; Ditaa
;; ;; ditaa setup for orgmode

;; (setq org-ditaa-jar-path 
;;       "/home/choppell/emacs/lisp/org-7.8.03/contrib/scripts/ditaa.jar")


;;; JS
(setq org-babel-js-cmd "~/apps/node-v4.6.0-linux-x64/bin/node")

;;; Python
(require 'ob-python)

;;; Shell
(require 'ob-sh)

;;; Scheme and Org-Babel
;;; ====================

;;; Scheme and Racket
(setq org-babel-scheme-cmd 
      "/home/choppell/apps/racket/racket-6.1.1/bin/racket")


;;; Org 8.0+ introduces Geiser as the environment for
;;; Scheme.  This messes up Racket Scheme's interaction with
;;; Babel.  The problem is that Geiser wraps Racket top
;;; level directives (like module, require, etc.) and Racket
;;; doesn't like that.


;;; Solution: Eliminate Geiser from the picture!  Racket's
;;; environment in emacs (the package racket-mode,
;;; obtainable from elpa) is pretty decent.


;;; Step 1. Install racket-mode from ELPA

;;; Step 2. Configure org-babel to use racket
     (setq org-babel-scheme-cmd
        "/home/choppell/apps/racket/racket-6.1.1/bin/racket")

;;; Step 3. Make racket-mode the mode to use for scheme.
     (add-to-list 'org-src-lang-modes (cons "scheme"  'racket))

;;; Step 4.  Use the org-scheme.el from org-7.9.2

;;;      cd org-8.3.1/lisp
;;;      cp  org-8.3.1/lisp/ob-scheme.el into ob-scheme.el.sav
;;;      ln -s ../../org-7.9.2/lisp/ob-scheme.el

;;; Step 5. Fix a bug in org-7.9.2/lisp/ob-scheme.el:

;;; Bug: In the function org-babel-execute:scheme 
;;;      emacs tries to read a scheme value, which makes no
;;;      sense.

;;; Solution: comment out the call to read in the above
;;;      function.



;;; Latex and HTML export
;;; =====================
;;; See
;;; http://orgmode.org/worg/org-tutorials/org-latex-export.html

;; (org-add-link-type "ebib" 'ebib)

;;; org-mode customization
(require 'ox-latex)
(add-to-list 'org-latex-classes
             '("exam"
               "\\documentclass{exam}"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))
             )

(add-to-list 'org-latex-classes
           '("IEEEtran"
              "\\documentclass{IEEEtran}"
              ("\\section{%s}" . "\\section*{%s}")
              ("\\subsection{%s}" . "\\subsection*{%s}")
              ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
              ("\\paragraph{%s}" . "\\paragraph*{%s}")
              ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

(add-to-list 'org-latex-classes
			 '("IEEEtran"
			   "\\documentclass{resume}"
			   ("\\section{%s}" . "\\section*{%s}")
			   ("\\subsection{%s}" . "\\subsection*{%s}")
			   ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
			   ("\\paragraph{%s}" . "\\paragraph*{%s}")
			   ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))



;;; see http://orgmode.org/worg/exporters/beamer/ox-beamer.html
;;; https://github.com/fniessen/refcard-org-beamer/blob/master/README.org
(require 'ox-latex)

  ;; update the list of LaTeX classes and associated header (encoding, etc.)
  ;; and structure
(add-to-list 'org-latex-classes
	     `("beamer"
	       ,(concat "\\documentclass[presentation]{beamer}\n"
			"[DEFAULT-PACKAGES]"
			"[PACKAGES]"
			"[EXTRA]\n")
	       ("\\section{%s}" . "\\section*{%s}")
	       ("\\subsection{%s}" . "\\subsection*{%s}")
	       ("\\subsubsection{%s}" . "\\subsubsection*{%s}")))


(setq org-latex-listings t)

;;; LaTeX Macros for HTML and LaTeX export
;;; (load "dblock") ;; in the same directory as org-custom.el




;;; File Apps
;;; =========
(setq org-file-apps 
 '((auto-mode . emacs)
   ("\\.mm\\'" . default)
   ("\\.x?html?\\'" . default)
   ("\\.pdf\\'" . "evince %s")))




;;; Journal

;;; (require 'org-journal)

;;;  Date Tree
;;; https://lists.gnu.org/archive/html/emacs-orgmode/2010-07/msg01056.html
;;; Creating a template
;;;;; Elisp code follows:




(defun create-dates-for-month-and-year (month year)
  "Create entries in date-tree format in current buffer.

 This function creates nodes for all days in given the given 
 MONTH and YEAR in the current buffer 
 (if they do not exist already).

"
  (let ((day 1)
        (max-days (if (= 2 month)
                        (if (date-leap-year-p year) 29 28)
                      (nth month
                           (list nil 31 28 31 30 31 30 31 31 30 31 30 31)))))
    (while (<= day max-days)
      (org-datetree-find-date-create (list month day year))
      (setq day (+ 1 day))
      )))

(defun create-dates-for-year (year)
  "Create entries in date-tree format in current buffer.

 This function creates nodes for all days in given YEAR
 in the current buffer (if they do not exist already).

"
  (let ((month 1))
    (while (<= month 12)
      (create-dates-for-month-and-year month year)
      (setq month (+ 1 month))
      )))


;;; Presentations with ox-reveal
;;; See https://github.com/yjwen/org-reveal/

(load-library "ox-reveal")
(setq org-reveal-root "file:///home/choppell/apps/reveal.js")

(setq org-reveal-plugins
      '(classList markdown highlight zoom notes search remotes
      multiplex title-footer))


;;;  for adding spans to elements

;;; Now you can type links such as:

;;; Check out this [[span:special][text block]].
;;; Which generates HTML output like:

;;; <p>Check out this <span class="special">text block</span>.</p>

;;; https://korewanetadesu.com/org-mode-spans.html
(defun jw/html-escape-attribute (value)
  "Entity-escape VALUE and wrap it in quotes."
  ;; http://www.w3.org/TR/2009/WD-html5-20090212/serializing-html-fragments.html
  ;;
  ;; "Escaping a string... consists of replacing any occurrences of
  ;; the "&" character by the string "&amp;", any occurrences of the
  ;; U+00A0 NO-BREAK SPACE character by the string "&nbsp;", and, if
  ;; the algorithm was invoked in the attribute mode, any occurrences
  ;; of the """ character by the string "&quot;"..."
  (let* ((value (replace-regexp-in-string "&" "&amp;" value))
         (value (replace-regexp-in-string "\u00a0" "&nbsp;" value))
         (value (replace-regexp-in-string "\"" "&quot;" value)))
    value))


(eval-after-load "org"
  '(org-add-link-type
    "span" #'ignore ; not an 'openable' link
    #'(lambda (class desc format)
        (pcase format
          (`html (format "<span class=\"%s\">%s</span>"
                         (jw/html-escape-attribute class)
                         (or desc "")))
          (_ (or desc ""))))))



;;; Automatically marking DONE when subtasks are all DONE.
;;; http://orgmode.org/manual/Breaking-down-tasks.html#Breaking-down-tasks
(defun org-summary-todo (n-done n-not-done)
       "Switch entry to DONE when all subentries are done, to TODO otherwise."
       (let (org-log-done org-log-states)   ; turn off logging
         (org-todo (if (= n-not-done 0) "DONE" "TODO"))))
     
     (add-hook 'org-after-todo-statistics-hook 'org-summary-todo)


;;; http://stackoverflow.com/questions/15773354/indent-code-in-org-babel-src-blocks
(setq org-src-tab-acts-natively t)

;;; http://stackoverflow.com/questions/20894683/control-indentation-with-org-babel
(setq org-src-preserve-indentation t)
;;; for python, make sure to insert a tab with ^q<TAB> if you want
;;; your python code indented in a block. 


;;; orgmode links
;;; see http://kitchingroup.cheme.cmu.edu/blog/2015/02/05/Extending-the-org-mode-link-syntax-with-attributes/

(org-add-link-type
 "slink"
 ;;  follow function
 (lambda (path)
   (let* ((data (read (format "(%s)" path)))
          (head (car data))
          (plist (cdr data))
          (link (org-element-context))
          (begin (org-element-property :begin link))
          (end (org-element-property :end link)))
     (setq plist (plist-put plist :last-clicked (current-time-string)))
     (save-excursion
     (setf (buffer-substring begin end) "")
     (goto-char begin)
     (insert (format "[[slink:%s %s]]" head
         (substring (format "%S" plist) 1 -1))))))
 ;; format function
 (lambda (path description backend)
   (let* ((data (read (concat "(" path ")")))
          (head (car data))
          (plist (cdr data)))
     (format "\\%s[%s][%s]{%s}"
             (plist-get plist :type)
             (plist-get plist :pre)
             (plist-get plist :post)
             head))))



;;; org-slide  mode
(require 'org-tree-slide)

(define-key org-mode-map (kbd "<f8>") 'org-tree-slide-mode)

(add-hook 'org-tree-slide-play-hook
		  (lambda () 
			(define-key org-tree-slide-mode-map (kbd "<left>") 'org-tree-slide-move-previous-tree)
			(define-key org-tree-slide-mode-map (kbd "<right>") 'org-tree-slide-move-next-tree)
			(define-key org-tree-slide-mode-map (kbd "<up>") 'org-tree-slide-content)))
  
;;; ?



(setq org-keep-stored-link-after-insertion t)



;;; Tangle marked files in dired
(load "dired-operations")

(defun dired-tangle-and-rsync-to-build-code ()
  (interactive)
  "Tangle marked files and push them to build/code directory if it exists"
  (let ((fns (dired-get-marked-files t)))
	
	(dolist (fn fns)
			(org-babel-tangle-file fn))
	
	(let ((dir (dired-current-directory)))
	  (if (string-match "/src/" dir)
		  (progn
			(let ((dest (replace-regexp-in-string "/src/" "/build/code/" dir)))
			  (let ((cmd (concat "rsync -a * " dest)))
				(print cmd)
				(dired-do-shell-command cmd nil fns)
				)))
		(error "you are probably not in a src directory")))))


;;; org-support-shift-select
;;; =========================

(setq org-support-shift-select t)


;;; Preview LaTeX


;;; see http://orgmode.org/worg/org-tutorials/org-latex-preview.html
(setq org-latex-create-formula-image-program 'imagemagick)
(setq org-format-latex-options (plist-put org-format-latex-options :scale 2.0))



;;; resume
(add-to-list 'org-latex-classes
			 '("res"
			   "\\documentclass{res}"
			   ("\\section{%s}" . "\\section*{%s}")
			   ("\\subsection{%s}" . "\\subsection*{%s}")
			   ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
			   ("\\paragraph{%s}" . "\\paragraph*{%s}")
			   ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))


(print "end  Venkatesh org-custom.el")
(print "end  Venkatesh org-custom.el")
(print "end  Venkatesh org-custom.el")


