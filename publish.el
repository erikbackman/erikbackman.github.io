(require 'package)

(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

(setq package-user-dir (expand-file-name "./.packages"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

(package-initialize)

(unless (package-installed-p 'htmlize)
  (package-refresh-contents)
  (package-install 'htmlize))

(require 'ox-publish)
(require 'ox-html)
(require 'htmlize)

(setq creator
      (format "Generated with <a href=\"https://www.gnu.org/software/emacs/\">Emacs</a> %s and <a href=\"https://orgmode.org\">Org</a> mode %s"
	      emacs-version (org-version))

      html-head "<link rel=\"stylesheet\" href=\"https://cdn.simplecss.org/simple.min.css\" /> <link rel=\"stylesheet\" href=\"../assets/style.css\" /> "
      
      org-publish-project-alist
      `(("notes"
	 :base-directory "./content/notes"
	 :base-extension "org"
	 :publishing-function org-html-publish-to-html
	 :publishing-directory "./docs/notes"
	 :with-author nil
	 :with-creator t
	 :creator ,creator
	 :with-toc nil
	 :section-numbers nil
	 :time-stamp-file nil
	 :html-preamble "<div id=bar><a href=../index.html>Index</a></div>"
	 :html-head ,html-head)
	("assets"
	 :base-directory "./assets"
	 :base-extension "css\\|ttf"
	 :publishing-directory "./docs/assets"
	 :publishing-function org-publish-attachment)
	("index"
	 :base-directory "./content"
	 :publishing-function org-html-publish-to-html
	 :publishing-directory "./docs"
	 :with-author nil
	 :with-creator t
	 :creator ,creator
	 :with-toc nil
	 :section-numbers nil
	 :time-stamp-file nil
	 :html-head ,html-head)
	("website"
	 :components ("index" "notes" "assets"))))

(setq org-html-validation-link nil
      org-html-head-include-scripts nil
      org-html-head-include-default-style nil
      org-html-validation-link nil
      org-src-fontify-natively t
      htmlize-face-overrides nil)

(org-publish-all t)

