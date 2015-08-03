((color-moccur status "installed" recipe
	       (:name color-moccur :website "https://github.com/myuhe/color-moccur.el" :description "multi-buffer occur (grep) mode" :type github :pkgname "myuhe/color-moccur.el"))
 (dash status "installed" recipe
       (:name dash :description "A modern list api for Emacs. No 'cl required." :type github :pkgname "magnars/dash.el"))
 (el-get status "installed" recipe
	 (:name el-get :website "https://github.com/dimitri/el-get#readme" :description "Manage the external elisp bits and pieces you depend upon." :type github :branch "master" :pkgname "dimitri/el-get" :info "." :compile
		("el-get.*\\.el$" "methods/")
		:features el-get :post-init
		(when
		    (memq 'el-get
			  (bound-and-true-p package-activated-list))
		  (message "Deleting melpa bootstrap el-get")
		  (unless package--initialized
		    (package-initialize t))
		  (when
		      (package-installed-p 'el-get)
		    (let
			((feats
			  (delete-dups
			   (el-get-package-features
			    (el-get-elpa-package-directory 'el-get)))))
		      (el-get-elpa-delete-package 'el-get)
		      (dolist
			  (feat feats)
			(unload-feature feat t))))
		  (require 'el-get))))
 (magit status "required" recipe nil)
 (with-eval-after-load-feature-el status "installed" recipe
				  (:name with-eval-after-load-feature-el :type github :pkgname "tarao/with-eval-after-load-feature-el" :after
					 (progn
					   (el-get-bundle-load-init "/home/kudos/.emacs.d/el-get/bundle-init/_home_kudos_.emacs.d_init-1_with-eval-after-load-feature-el.el")))))
