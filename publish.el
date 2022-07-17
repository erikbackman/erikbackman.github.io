(require 'package)

(setq package-user-dir (expand-file-name "./.packages"))
(setq package-archives '(("melpa" . "https://melpa.org/packages")))

;(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))


(unless (package-installed-p 'htmlize)
 (package-install 'htmlize))

(require 'ox-publish)
(setq org-src-fontify-natively t)
(require 'ox-html)
(require 'htmlize)
(setq htmlize-face-overrides nil)

;; (setq htmlize-face-overrides
;;       '(font-lock-warning-face \"black\"
;; 			       font-lock-function-name-face \"red\"
;; 			       font-lock-comment-face \"blue\"
;; 			       default (:foreground \"dark-green\" :background \"yellow\")))

;; There is a bug in ox-html, which doesn't check for empty string in
;; properties, so `org-html-extension' should set using variable.
(setq org-publish-project-alist
      (list
       (list "my-org-site"
             :recursive t
             :base-directory "./content"
             :publishing-function 'org-html-publish-to-html
             :publishing-directory "./docs"
             :with-author nil           ;; Don't include author name
             :with-creator t            ;; Include Emacs and Org versions in footer
             :with-toc nil                ;; Include a table of contents
             :section-numbers nil       ;; Don't include section numbers
             :time-stamp-file nil)))    ;; Don't include time stamp in file

(setq org-html-validation-link nil            ;; Don't show validation link
      org-html-head-include-scripts nil       ;; Use our own scripts
      org-html-head-include-default-style nil ;; Use our own styles

      org-html-head "<link rel=\"stylesheet\" href=\"https://cdn.simplecss.org/simple.min.css\" />
                     <link rel=\"stylesheet\" href=\"./assets/style.css\" />")

(setq org-html-validation-link nil)
(org-publish-all t)

