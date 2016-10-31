;;PACKAGES
(require 'package)
  (add-to-list
   'package-archives
   '("melpa" . "http://melpa.org/packages/")
   t)
  (add-to-list
   'package-archives
   '("gnu" . "https://elpa.gnu.org/packages/")
   t)
  (add-to-list
   'package-archives
   '("marmalade" . "https://marmalade-repo.org/packages/")
   t)

;; (add-to-list
;;  'load-path
;;  "~/.emacs.d/repos/org-mode/lisp")

(package-initialize)

;; SMEX
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)

;;IDO
(require 'ido)
(ido-mode t)

;;HAL
(add-to-list 'auto-mode-alist '("\\.hal\\'" . org-mode))

;;FROM CUSTOMIZE
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-custom-commands
   (quote
    (("0" "Upper Priority"
      ((tags-todo "ACTIVE=\"t\"+DONE=\"nil\"+URGENCY>5" nil))
      nil)
     ("9" "Top Initiatives"
      ((tags-todo "ACTIVE=\"t\"+DONE=\"nil\"+URGENCY=5" nil))
      nil)
     ("8" "Ready to Prioritize"
      ((tags-todo "ACTIVE=\"t\"+DONE=\"nil\"+URGENCY<5-URGENCY<2" nil))
      nil)
     ("n" "Need"
      ((tags "NEED=\"t\"" nil))
      nil)
     ("k" "Stock"
      ((tags "TODO=\"ITEM\"+STOCK=\"t\"" nil))
      nil)
     ("u" "Stuck"
      ((tags "stuck" nil))
      nil)
     ("b" "Buttons"
      ((todo "BUTTON"))
      nil))))
 '(org-agenda-files (quote ("~/Org")))
 '(org-agenda-sorting-strategy
   (quote
    ((agenda habit-down time-up priority-down category-keep)
     (todo todo-state-up priority-down category-keep)
     (tags priority-down category-keep)
     (search category-keep))))
 '(org-agenda-tags-todo-honor-ignore-options t)
 '(org-agenda-todo-ignore-scheduled (quote all))
 '(org-agenda-use-tag-inheritance (quote (todo search timeline agenda tags)))
 '(org-archive-location "archive.org_archive::datetree/* From %s")
 '(org-columns-default-format
   "%25ITEM %TODO %3ACTIVE %3DONE %3DURATION %URGENCY 6%LOCATION")
 '(org-confirm-elisp-link-function nil)
 '(org-drawers (quote ("PROPERTIES" "CLOCK" "LOGBOOK" "RESULTS" "NOTES")))
 '(org-global-properties
   (quote
    (("ACTIVE_ALL" . "nil t")
     ("DONE_ALL" . "nil t")
     ("CONDITION-TYPE_ALL" . "\"active\" \"done\"")
     ("URGENCY_ALL" . "n 1 2 3 4 5 6 7 8 9")
     ("NEED_ALL" . "nil t")
     ("STOCK_ALL" . "nil t"))))
 '(org-hide-leading-stars t)
 '(org-id-link-to-org-use-id (quote create-if-interactive))
 '(org-indent-mode-turns-off-org-adapt-indentation nil)
 '(org-log-into-drawer t)
 '(org-refile-targets (quote ((org-agenda-files :regexp . "Inbox"))))
 '(org-todo-keywords
   (quote
    ((sequence "PROCESS(p!)" "NOTICE(n!)" "|" "RESOLVED(r!)" "JOURNAL(j)" "INFO(i)")
     (sequence "ACTION!(`)" "ACTION(1)" "BREAKDOWN(2)" "|" "DONE(3!)")
     (sequence "BUTTON(b)" "STOCK(k)" "|")
     (sequence "|" "PERSON(P)" "ITEM(I)" "LOCATION(L)")
     (sequence "APPOINTMENT(A)" "|")
     (sequence "WORK(w)" "|")
     (sequence "SEQUENCE(Q)" "MOVEMENT(M)" "|"))))
 '(org-use-property-inheritance (quote ("URGENCY")))
 '(org-yank-folded-subtrees nil)
 '(send-mail-function (quote mailclient-send-it)))

;;ORG BASICS

(define-key global-map "\C-cc" 'org-capture)
(define-key global-map "\C-ca" 'org-agenda)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-c C-l" 'org-insert-link)

					;local keybindings
(add-hook 'org-mode-hook
	  '(lambda ()
	     (define-key org-mode-map "\M-p" 'org-insert-heading)))
(add-hook 'org-mode-hook
	  '(lambda ()
	     (define-key org-mode-map "\M-\^M" 'org-insert-heading-respect-content)))
(add-hook 'org-mode-hook
	  '(lambda ()
	     (define-key org-mode-map "\C-c0" 'org-demote-subtree)))
(add-hook 'org-mode-hook
	  '(lambda ()
	     (define-key org-mode-map "\C-c9" 'org-promote-subtree)))
					; minor modes
(add-hook 'org-mode-hook
	  'visual-line-mode)

(add-hook 'org-capture-before-finalize-hook
	  'lorg-set-id)

;;ORG CAPTURE

(setq org-capture-templates
      '(("j" "Journal" entry (file+datetree "~/org/journal.org")
	 "* JOURNAL %U\n%i%?")
	("J" "Journal+" entry (file+datetree "~/org/journal.org")
	 "* JOURNAL %?\n:NOTES:\nCreated: %U\n:END:")
	("p" "Process" entry (file+datetree "~/org/journal.org")
	 "* PROCESS %?\n%i\n:PROPERTIES:\n:ACTIVE: t\n:DONE: nil\n:URGENCY: 5\n:END:")
	("n" "Notice" entry (file+datetree "~/org/journal.org")
	 "* NOTICE %?%i\n:PROPERTIES:\n:ACTIVE: t\n:DONE: nil\n:URGENCY: 6\n:END:")
	("M" "Main Captures")
	("M`" "Action!" entry (file+headline "~/org/main.org" "Initiatives")
	 "* ACTION! %i%?\n:PROPERTIES:\n:ACTIVE: t\n:DONE: nil\n:URGENCY: 5\n:END:")
	("M1" "Action" entry (file+headline "~/org/main.org" "Initiatives")
	 "* ACTION %i%?\n:PROPERTIES:\n:ACTIVE: t\n:DONE: nil\n:URGENCY: 5\n:END:")
	("M2" "Breakdown" entry (file+headline "~/org/main.org" "Initiatives")
	 "* BREAKDOWN %i%?\n:PROPERTIES:\n:ACTIVE: t\n:DONE: nil\n:URGENCY: 5\n:END:")
	("Mb" "Button" entry (file+headline "~/org/main.org" "Buttons")
	 "* BUTTON %i%?\n:PROPERTIES:\n:ACTIVE: nil\n:COLUMNS: %25ITEM %6TODO %3ACTIVE\n:END:")
	("MI" "Item" entry (file+headline "~/org/main.org" "Items")
	 "* ITEM %i%?\n:PROPERTIES:\n:COLUMNS: %15ITEM %3STOCK %3NEED %3SPEC %3QUANTITY %3UNIT %5LOCATION\n:STOCK: nil\n:NEED: nil\n:SPEC: 0\n:QUANTITY: 1\n:UNIT:\n:LOCATION: \n:END:")
	("ML" "Location" entry (file+headline "~/org/main.org" "Locations")
	 "* LOCATION %i%?")
	("MA" "Appointment" entry (file+headline "~/org/main.org" "Appointments")
	 "* APPOINTMENT %?\n  %i\n")
	("Mi" "Info" entry (file+datetree "~/org/main.org")
	 "* INFO %?\n%i")
	("Mk" "Stock" entry (file+datetree "~/org/main.org")
	 "* STOCK %i%?")
	("G" "GORG Captures")
	("G`" "Gorg Action!" entry (file+headline "~/org/gorg.org" "Initiatives")
	 "* ACTION! %i%?\n:PROPERTIES:\n:ACTIVE: t\n:DONE: nil\n:URGENCY: 5\n:END:")
	("G1" "Gorg Action" entry (file+headline "~/org/gorg.org" "Initiatives")
	 "* ACTION %i%?\n:PROPERTIES:\n:ACTIVE: t\n:DONE: nil\n:URGENCY: 5\n:END:")
	("G2" "Gorg Breakdown" entry (file+headline "~/org/gorg.org" "Initiatives")
	 "* BREAKDOWN %i%?\n:PROPERTIES:\n:ACTIVE: t\n:DONE: nil\n:URGENCY: 5\n:END:")
	("Gj" "Gorg Journal" entry (file+datetree "~/org/gorg.org")
	 "* JOURNAL %U\n%i%?")
	("Gi" "Gorg Info" entry (file+datetree "~/org/gorg.org")
	 "* INFO %?\n%i")
	("H" "HAL Captures")
	("H`" "HAL Action!" entry (file+headline "~/org/hal.org" "Initiatives")
	 "* ACTION! %i%?\n:PROPERTIES:\n:ACTIVE: t\n:DONE: nil\n:URGENCY: 5\n:END:")
	("H1" "HAL Action" entry (file+headline "~/org/hal.org" "Initiatives")
	 "* ACTION %i%?\n:PROPERTIES:\n:ACTIVE: t\n:DONE: nil\n:URGENCY: 5\n:END:")
	("H2" "HAL Breakdown" entry (file+headline "~/org/hal.org" "Initiatives")
	 "* BREAKDOWN %i%?\n:PROPERTIES:\n:ACTIVE: t\n:DONE: nil\n:URGENCY: 5\n:END:")
	("Hj" "HAL Journal" entry (file+datetree "~/org/hal.org")
	 "* JOURNAL %U\n%i%?")
	("Hi" "HAL Info" entry (file+datetree "~/org/hal.org")
	 "* INFO %?\n%i")
	("W" "Work Captures")
	("W`" "Work Action!" entry (file+headline "~/org/work.org" "Initiatives")
	 "* ACTION! %i%?\n:PROPERTIES:\n:ACTIVE: t\n:DONE: nil\n:URGENCY: 5\n:END:")
	("W1" "Work Action" entry (file+headline "~/org/work.org" "Initiatives")
	 "* ACTION %i%?\n:PROPERTIES:\n:ACTIVE: t\n:DONE: nil\n:URGENCY: 5\n:END:")
	("W2" "Work Breakdown" entry (file+headline "~/org/work.org" "Initiatives")
	 "* BREAKDOWN %i%?\n:PROPERTIES:\n:ACTIVE: t\n:DONE: nil\n:URGENCY: 5\n:END:")
	("Wb" "Work Button" entry (file+headline "~/org/work.org" "Buttons")
	 "* BUTTON %i%?\n:PROPERTIES:\n:ACTIVE: nil\n:COLUMNS: %25ITEM %6TODO %3ACTIVE\n:END:")
	("Wj" "Work Journal" entry (file+datetree "~/org/work.org")
	 "* JOURNAL %U\n%?")
	("Wi" "Work Info" entry (file+datetree "~/org/work.org")
	 "* INFO %?\n%i")
	("WI" "Work Item" entry (file+headline "~/org/work.org" "Items")
	 "* ITEM %i%?\n:PROPERTIES:\n:COLUMNS: %15ITEM %3STOCK %3NEED %3SPEC %3QUANTITY %3UNIT %5LOCATION\n:STOCK: nil\n:NEED: nil\n:SPEC: 0\n:QUANTITY: 1\n:UNIT:\n:LOCATION: \n:END:")
	("Wj" "Work Journal" entry (file+datetree "~/org/work.org")
	 "* JOURNAL %U\n%i%?")
	("Ww" "Work Work" entry (file+headline "~/org/work.org" "Shifts")
	 "* WORK %U\n%i%?")
	("B" "Body Captures")
	("B`" "Body Action!" entry (file+headline "~/org/body.org" "Initiatives")
	 "* ACTION %i%?\n:PROPERTIES:\n:ACTIVE: t\n:DONE: nil\n:URGENCY: 5\n:END:")
	("B1" "Body Action" entry (file+headline "~/org/body.org" "Initiatives")
	 "* ACTION %i%?\n:PROPERTIES:\n:ACTIVE: t\n:DONE: nil\n:URGENCY: 5\n:END:")
	("B2" "Body Breakdown" entry (file+headline "~/org/body.org" "Initiatives")
	 "* BREAKDOWN %i%?\n:PROPERTIES:\n:ACTIVE: t\n:DONE: nil\n:URGENCY: 5\n:END:")
	("Bb" "Body Button" entry (file+headline "~/org/body.org" "Buttons")
	 "* BUTTON %i%?\n:PROPERTIES:\n:ACTIVE: nil\n:COLUMNS: %25ITEM %6TODO %3ACTIVE\n:END:")
	("Bj" "Body Journal" entry (file+datetree "~/org/body.org")
	 "* JOURNAL %U\n%?")
	("Bi" "Body Info" entry (file+datetree "~/org/body.org")
	 "* INFO %?\n%i")
	("BI" "Body Item" entry (file+headline "~/org/body.org" "Items")
	 "* ITEM %i%?\n:PROPERTIES:\n:COLUMNS: %15ITEM %3STOCK %3NEED %3SPEC %3QUANTITY %3UNIT %5LOCATION\n:STOCK: nil\n:NEED: nil\n:SPEC: 0\n:QUANTITY: 1\n:UNIT:\n:LOCATION: \n:END:")
	("Bj" "Body Journal" entry (file+datetree "~/org/body.org")
	 "* JOURNAL %U\n%i%?")
	("F" "Food Captures")
	("F`" "Food Action!" entry (file+headline "~/org/food.org" "Initiatives")
	 "* ACTION! %i%?\n:PROPERTIES:\n:ACTIVE: t\n:DONE: nil\n:URGENCY: 5\n:END:")
	("F1" "Food Action" entry (file+headline "~/org/food.org" "Initiatives")
	 "* ACTION %i%?\n:PROPERTIES:\n:ACTIVE: t\n:DONE: nil\n:URGENCY: 5\n:END:")
	("F2" "Food Breakdown" entry (file+headline "~/org/food.org" "Initiatives")
	 "* BREAKDOWN %i%?\n:PROPERTIES:\n:ACTIVE: t\n:DONE: nil\n:URGENCY: 5\n:END:")
	("Fb" "Food Button" entry (file+headline "~/org/food.org" "Buttons")
	 "* BUTTON %i%?\n:PROPERTIES:\n:ACTIVE: nil\n:COLUMNS: %25ITEM %6TODO %3ACTIVE\n:END:")
	("FI" "Food Item" entry (file+headline "~/org/food.org" "Items")
	 "* ITEM %i%?\n:PROPERTIES:\n:COLUMNS: %15ITEM %3STOCK %3NEED %3SPEC %3QUANTITY %3UNIT %5LOCATION\n:STOCK: nil\n:NEED: nil\n:SPEC: 0\n:QUANTITY: 1\n:UNIT:\n:LOCATION: \n:END:")
	("Fj" "Food Journal" entry (file+datetree "~/org/food.org")
	 "* JOURNAL %U\n%i%?")
	("Fi" "Food Info" entry (file+datetree "~/org/food.org")
	 "* INFO %?\n%i")
	("FA" "Food Appointment" entry (file+headline "~/org/food.org" "Appointments")
	 "* APPOINTMENT %?\n  %i\n")
	("Fk" "Food Stock" entry (file+datetree "~/org/food.org")
	 "* STOCK %i%?")
	("L" "Lorg Captures")
	("L`" "Lorg Action!" entry (file+headline "~/org/lorg.org" "Initiatives")
	 "* ACTION! %i%?\n:PROPERTIES:\n:ACTIVE: t\n:DONE: nil\n:URGENCY: 5\n:END:")
	("L1" "Lorg Action" entry (file+headline "~/org/lorg.org" "Initiatives")
	 "* ACTION %i%?\n:PROPERTIES:\n:ACTIVE: t\n:DONE: nil\n:URGENCY: 5\n:END:")
	("L2" "Lorg Breakdown" entry (file+headline "~/org/lorg.org" "Initiatives")
	 "* BREAKDOWN %i%?\n:PROPERTIES:\n:ACTIVE: t\n:DONE: nil\n:URGENCY: 5\n:END:")
	("Lb" "Lorg Button" entry (file+headline "~/org/lorg.org" "Buttons")
	 "* BUTTON %i%?\n:PROPERTIES:\n:ACTIVE: nil\n:COLUMNS: %25ITEM %6TODO %3ACTIVE\n:END:")
	("Lj" "Lorg Journal" entry (file+datetree "~/org/lorg.org")
	 "* JOURNAL %U\n%i%?")
	("Li" "Lorg Info" entry (file+datetree "~/org/lorg.org")
	 "* INFO %?\n%i")
	("C" "Car Captures")
	("C`" "Car Action!" entry (file+headline "~/org/car.org" "Initiatives")
	 "* ACTION! %i%?\n:PROPERTIES:\n:ACTIVE: t\n:DONE: nil\n:URGENCY: 5\n:END:")
	("C1" "Car Action" entry (file+headline "~/org/car.org" "Initiatives")
	 "* ACTION %i%?\n:PROPERTIES:\n:ACTIVE: t\n:DONE: nil\n:URGENCY: 5\n:END:")
	("C2" "Car Breakdown" entry (file+headline "~/org/car.org" "Initiatives")
	 "* BREAKDOWN %i%?\n:PROPERTIES:\n:ACTIVE: t\n:DONE: nil\n:URGENCY: 5\n:END:")
	("Cb" "Car Button" entry (file+headline "~/org/car.org" "Buttons")
	 "* BUTTON %i%?\n:PROPERTIES:\n:ACTIVE: nil\n:COLUMNS: %25ITEM %6TODO %3ACTIVE\n:END:")
	("CA" "Appointment" entry (file+headline "~/org/car.org" "Appointments")
	 "* APPOINTMENT %?\n  %i\n")
	("Cj" "Car Journal" entry (file+datetree "~/org/car.org")
	 "* JOURNAL %U\n%i%?")
	("Ci" "Car Info" entry (file+datetree "~/org/car.org")
	 "* INFO %?\n%i")))

;;ORG APPEARANCE
(set 'org-startup-indented t)
(setq org-todo-keyword-faces
      '(("SEQUENCE" . "dark orange")("MOVEMENT" . "purple")("PERSON" . "blue")))

;;ORG MOBILE

;; Set to the location of your Org files on your local system
(setq org-directory "~/org")
;; Set to the name of the file where new notes will be stored
(setq org-mobile-inbox-for-pull "~/org/mobile-pull.org")
;; Set to <your Dropbox root directory>/MobileOrg.
(setq org-mobile-directory "~/Dropbox/Apps/MobileOrg")
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;----------------------------------------------------------------------------------
;                                        LORG
;----------------------------------------------------------------------------------

;;LORG_ID

(set 'last-lorg-id-number 3886)

(defun lorg-set-id ()
  "Accepts no arguments.  If the entry at point already has a LORG_ID property, do nothing.  If there is no such property, create it and assign as its value the value of variable last-lorg-id-number, incremented by one.  Change the value of last-lorg-id-number to this new value, and change it in the init file as well."
  (interactive nil)
  (let ((curret-point nil)
	(current-buffer nil))
    (set 'current-point (point))
    (set 'current-buffer (current-buffer))
    (if (org-entry-get (point) "LORG_ID")
	nil
         (set 'last-lorg-id-number (+ last-lorg-id-number 1))
      (org-entry-put (point) "LORG_ID" (number-to-string last-lorg-id-number))
      (find-file "~/.emacs.d/init.el")
      (beginning-of-buffer)
      (re-search-forward "(set 'last-lorg-id-number ")
      (delete-region (point) (line-end-position))
      (insert (concat (number-to-string last-lorg-id-number) ")"))
      (save-buffer)
      (switch-to-buffer current-buffer)
      (goto-char current-point))
    (print "ID set.")))

(defun lorg-set-all-id ()
  "Accepts no arguments.  Visits each org entry and gives it a unique LORG_ID if it doesn't have one."
  (interactive nil)
  (save-excursion
    (org-map-entries '(lorg-set-id) t 'agenda)
    (print "All IDs set.")))

(defun lorg-get-id ()
  "Accepts as argument point-or-marker.  Returns a string containing the LORG_ID of the entry at point."
  (org-entry-get (point) "LORG_ID"))

(defun lorg-find-entry-id (id switch)
  "Accepts as argument A) a string specifying a LORG_ID number, and B) a t or nil specifying whether to switch the window focus once the entry is found.  Moves point to the org entry with that number."
  (interactive "sentry id number:\nd" )
    (let ((target-point nil)
	  (target-buffer nil))
      (org-map-entries '(if (equal (lorg-get-id) id)
			    (progn
			      (set 'target-point (point))
			      (set 'target-buffer (current-buffer)))
			  nil) t 'agenda)
      (if target-point
	  (if switch
	      (progn
		(switch-to-buffer target-buffer)
		(goto-char target-point)
		(org-reveal))
	    (progn
	      (set-buffer target-buffer)
	      (goto-char target-point)))
	nil)))
      
;;LORG CONDITIONS

;getting and setting conditions


(set 'current-condition nil)

(defun lorg-store-condition-id ()
  (interactive nil)
  (set 'current-condition (lorg-get-id))
  (print "Condition ID stored."))

(defun lorg-set-condition-id ()
  "Accepts no arguments.  Stores the value of the global variable 'current-condition as the CONDITION-ID property of the entry at point."
  (interactive nil)
  (org-entry-put (point) "CONDITION-ID" current-condition)
  (print "Condition ID set."))

(defun lorg-set-condition-type (type-abbrev)
  "Accepts as argument a string containing a condition type abbreviation.  As of this writing, that value should be either the letter 'a' or the letter 'd', signifying 'active' or 'done'.  Sets the CONDITION-TYPE property of the entry at point."
  (interactive "scondition type (either \"a\" or \"d\"):")
  (if (equal type-abbrev "a")
      (progn (org-entry-put (point) "CONDITION-TYPE" "active") (print "Condition type set to 'active'."))
    (if (equal type-abbrev "d")
      (progn (org-entry-put (point) "CONDITION-TYPE" "done") (print "Condition type set to 'done'."))
      (print "No condition type match."))))

;;LORG UPDATING;;

(defun lorg-test-condition-active ()
  "Accepts no arguments.  Returns the ACTIVE property of the entry at point."
  (org-entry-get (point) "ACTIVE"))

(defun lorg-test-condition-done ()
  "Accepts no arguments.  Returns the DONE property of the entry at point."
  (org-entry-get (point) "DONE"))
    
(defun lorg-test-condition(id condtyp)
  "Accepts as argument a A) string specifying a LORG_ID, and B) a string specifying the type of condition being tested. B should be either the string 'active' or the string 'done.'  Visits the entry which corresponds to the LORG_ID, and returns a test of that entry appropriate to the condition type passed in."
  (lorg-find-entry-id id nil)
  (if (equal condtyp "active")
      (lorg-test-condition-active)
    (if (equal condtyp "done")
	(lorg-test-condition-done)
      (print "Not a valid condition type."))))

(defun lorg-update-entry()
  "Accepts no arguments.  Updates the ACTIVE property of the entry at point by checking its CONDITION-ID and CONDITION-TYPE properties."
  (interactive)
  (let ((condition-id nil)
	(condition-type nil)
	(condition-met nil))
    (set 'condition-id (org-entry-get (point) "CONDITION-ID"))
    (set 'condition-type (org-entry-get (point) "CONDITION-TYPE"))

    (if (and condition-type condition-id)
	(set 'condition-met (save-excursion
			      (lorg-test-condition condition-id condition-type)))
      (if (or condition-type condition-id)
	  (print (concat "Entry at " (lorg-get-id) " missing condition components."))
	nil))

    (if condition-met
	(lorg-activate-entry)
      nil))
  )

;; (defun lorg-garbage-collect-entry()				    
;;   "Accepts no arguments.  Checks to see if the ACTIVE and DONE properties are nil-t in the entry at point.  If so, it archives the entry."
;;   (if (and (not (org-entry-get (point) "ACTIVE")) (org-entry-get (point) "DONE"))
;;       (org-archive-subtree)
;;     nil))

(defun lorg-update-subtree()
  "Accepts no arguments.  Updates and garbage collects org entries in the subtree at point."
  (interactive nil)
  (org-map-entries '(lorg-update-entry) t 'tree)
  (print "Activities in tree updated."))

(defun lorg-update-all()
  "Accepts no arguments.  Updates and garbage collects org entries in the subtree at point."
  (interactive nil)
  (org-map-entries '(lorg-update-entry) t 'agenda)
  (print "Activities updated."))

;;LORG RESETTING;;

(defun lorg-reset-entry()
  "Accepts no arguments.  Resets the ACTIVE and DONE properties of the entry at point."
  (interactive)
  (progn
    (org-entry-put (point) "ACTIVE" "nil")
    (org-entry-put (point) "DONE" "nil")
    (setq current-prefix-arg '(4))
    (call-interactively 'org-schedule)
    (if (org-entry-get (point) "TAGS")
	(if (member "ARCHIVE" (split-string (org-entry-get (point) "TAGS") ":"))
	    (org-toggle-archive-tag)
	  nil)
      nil)
    (print "Entry reset.")))

(defun lorg-reset-subtree()
  "Accepts no arguments.  Resets the ACTIVE and DONE properties of the subtree beginning with the entry at point."
  (interactive)
  (org-map-entries '(lorg-reset-entry)
		   t 'tree))

(defun lorg-set-subtree-properties()
  "Accepts no arguments.  Sets the inherited properties of each subtree item to the values of the those same properties in the entry at point.  Grabs the list of properties to inherit from the variable 'org-use-property-inheritance."
  (interactive)
  (dolist (elt org-use-property-inheritance nil)
    (let ((prop-name nil)
	  (prop-value nil))
      (set 'prop-name elt)
      (set 'prop-value (org-entry-get (point) prop-name))
      (org-map-entries '(org-entry-put (point) prop-name prop-value) t 'tree)))
  (print (concat "Entry properties inherited.")))
  
;;LORG LINKING;;

(defvar lorg-current-stored-link nil
  "Contains a string which holds the link produced by the last usage of 'lorg-store-link.")

(defun lorg-store-link ()
  "Accepts no arguments.  Stores a string consisting of a well-formed link to the entry at pointnnnpp in 'lorg-current-stored-link."
  (interactive)
  (let ((lorg-item nil)
	(lorg-entry-name nil)
	(lorg-id nil))
    (set 'lorg-item (org-entry-get (point) "ITEM"))
    (set 'lorg-entry-name (replace-regexp-in-string "\*+ " "" lorg-item))
    (set 'lorg-id (lorg-get-id))
    (if (not lorg-id)
	(print "Target entry has no LORG_ID.")
      
      (set 'lorg-current-stored-link (concat "[[elisp:(lorg-find-entry-id \""
					     lorg-id
					     "\" t)]["
					     lorg-entry-name
					     "]]"))
      (print (concat  "Link stored for: " lorg-entry-name ".")))))

(defun lorg-insert-link ()
  "Accepts no arguments.  Inserts the contents of 'lorg-current-stored-link at point."
  (interactive)
  (if lorg-current-stored-link
      (insert lorg-current-stored-link)
    (print "No link has been stored.")))

;;LORG LOCATIONS
(defun lorg-location-examine-contents()
  "Accepts no arguments.  Opens a tags agenda view containing the contents of the LOCATION at point."
  (interactive)
  (if (equal (org-entry-get (point) "TODO") "LOCATION")
      (let ((locations-list '())
	    (match-list '())
	    (match-string ""))

	(org-map-entries '(set 'locations-list (cons (org-entry-get (point) "LORG_ID") locations-list)) t 'tree)

	(dolist (elt locations-list nil)
	  (set 'match-list (cons `(,(concat "LOC_ID=\"" elt "\"")) match-list)))

	(dolist (elt match-list nil)
	  (set 'match-string (concat (car elt) "|" match-string)))

	(org-tags-view nil match-string))
    (print "This entry is not a LOCATION.")))

(defvar lorg-current-stored-location nil
  "A cons cell containing the name and lorg id of the LOCATION where lorg-store-location was last used.")

(defun lorg-store-location()
  "Accepts no arguments.  Stores the name of and a link to the LOCATION at point in 'lorg-current-stored-location."
  (interactive)
  (if (equal (org-entry-get (point) "TODO") "LOCATION")
      (let ((lorg-item nil)
	    (lorg-entry-name nil)
	    (lorg-id nil)
	    (lorg-entry-link nil))
	(set 'lorg-item (org-entry-get (point) "ITEM"))
	(set 'lorg-entry-name (replace-regexp-in-string "\*+ " "" lorg-item))
	(set 'lorg-id (lorg-get-id))
	(set 'lorg-current-stored-location (cons lorg-entry-name lorg-id))
	(print (concat "Location: " (car lorg-current-stored-location) " stored.")))
    (print "This entry is not a LOCATION.")))
  
(defun lorg-set-location()
  "Accepts no arguments.  Sets the location related properties of the entry at point: LOCATION to the car of 'lorg-current-stored-location, and LOC_LINK to the cdr."
  (interactive)
  (org-entry-put (point) "LOCATION" (car lorg-current-stored-location))
  (org-entry-put (point) "LOC_ID" (cdr lorg-current-stored-location))
  (print (concat "Location set to " (car lorg-current-stored-location))))

(defun lorg-visit-location()
  "Accepts no arguments.  Brings point to the location of the item at point, by following the lorg id stored in it's LOC_ID property."
  (interactive)
  (lorg-find-entry-id (org-entry-get (point) "LOC_ID") t))

;; LORG ACTIVATE

(defun lorg-activate-entry()
  "Accepts no arguments.  Activates the entry at point."
  (interactive)
  (if (equal (org-entry-get (point) "DONE") "t")
      nil
    (org-entry-put (point) "ACTIVE" "t")
    (org-entry-put (point) "DONE" "nil")
    (print "Entry activated.")))

(defun lorg-activate-subtree(arg)
  "Accepts a prefix argument.  Activates the subtree at point.  Without the prefix arg, calls lorg-activate-entry and lorg-update-subtree on the entry at point.  With the prefix arg, calls lorg-activate-entry on the entry at point and each individual member of the subtree which begins at point."
  (interactive "P")
  (if arg
      (org-map-entries '(lorg-activate-entry) t 'tree)
    (lorg-activate-entry)
    (lorg-update-subtree)))

;; LORG DONE
(defun lorg-done-entry()
  "Accepts no arguments.  Completes, soft archives, and unschedules the item at point.  If the item has the flag RECURRING, unschedules and resets the subtree which begins with that entry."
  (interactive)
  (if (equal (org-entry-get (point) "RECURRING") "t")
      (lorg-reset-subtree)
    (setq current-prefix-arg '(4))
    (call-interactively 'org-schedule)
    (org-toggle-archive-tag)
    (org-entry-put (point) "ACTIVE" "t")
    (org-entry-put (point) "DONE" "t")
    (print "Done.")))

;; LORG RECURRING
(defun lorg-recurring-toggle()
  "Toggles the recurring status of the entry at point."
  (interactive)
  (if (equal (org-entry-get (point) "RECURRING") "t")
      (org-entry-put (point) "RECURRING" "nil")
    (org-entry-put (point) "RECURRING" "t"))
  (print (org-entry-get (point) "RECURRING")))

;;LORG COMMANDS FROM AGENDA VIEW

(defun lorg-modified-org-agenda-goto (&optional highlight)
  "Go to the entry at point in the corresponding Org-mode file."
  (interactive)
  (let* ((marker (or (org-get-at-bol 'org-marker)
		     (org-agenda-error)))
	 (buffer (marker-buffer marker))
	 (pos (marker-position marker)))
    (set-buffer buffer)
    (widen)
    (push-mark)
    (goto-char pos)
    (when (derived-mode-p 'org-mode)
      (org-show-context 'agenda)
      (save-excursion
	(and (outline-next-heading)
	     (org-flag-heading nil)))	; show the next heading
      (when (outline-invisible-p)
	(outline-show-entry))			; display invisible text
      (recenter (/ (window-height) 2))
      (org-back-to-heading t)
      (if (re-search-forward org-complex-heading-regexp nil t)
	  (goto-char (match-beginning 4))))
    (run-hooks 'org-agenda-after-show-hook)
    (and highlight (org-highlight (point-at-bol) (point-at-eol)))))

;;LORG DROPBOX/MOBILE/BACKUP
(defun lorg-git-push-orgfiles ()
  "Accepts no arguments.  Runs a sequence of kbd macros that navigates to the org folder, adds and commits everything to the git repository there, and then pushes it to the dropbox master branch."
  (interactive)
 (shell)
 (execute-kbd-macro "cd ~/Org")
 (execute-kbd-macro (kbd "RET"))
 (execute-kbd-macro "git add .")
 (execute-kbd-macro (kbd "RET"))
 (execute-kbd-macro "git commit -m \"routine commit and push\"")
 (execute-kbd-macro (kbd "RET"))
 (execute-kbd-macro "git push db master")
 (execute-kbd-macro (kbd "RET")))

(defun lorg-git-push-.emacs.d ()
  "Accepts no arguments.  Runs a sequence of kbd macros that navigates to the emacs init folder, adds and commits everything to the git repository there, and then pushes it to the dropbox master branch."
  (interactive)
 (shell)
 (execute-kbd-macro "cd ~/.emacs.d")
 (execute-kbd-macro (kbd "RET"))
 (execute-kbd-macro "git add .")
 (execute-kbd-macro (kbd "RET"))
 (execute-kbd-macro "git commit -m \"routine commit and push\"")
 (execute-kbd-macro (kbd "RET"))
 (execute-kbd-macro "git push db master")
 (execute-kbd-macro (kbd "RET")))

(defun lorg-git-push-all ()
  "Accepts no arguments.  Backups both the orgfiles and the emacs init folder."
  (interactive)
     (lorg-git-push-orgfiles)
     (lorg-git-push-.emacs.d))

(defun lorg-git-and-mobile-push ()
  "Accepts no arguments.  Backups the orgfiles and emacs init folder, and pushes the org files to mobile-org."
  (interactive)
  (lorg-git-push-all)
  (org-mobile-push))

;; LORG AGENDA MODE COMMANDS
  
;;LORG KEYBINDINGS

(define-prefix-command 'lorg-map)
(define-prefix-command 'lorg-condition-map)
(define-prefix-command 'lorg-update-map)
(define-prefix-command 'lorg-id-map)
(define-prefix-command 'lorg-reset-map)
(define-prefix-command 'lorg-properties-inheritance-map)
(define-prefix-command 'lorg-link-map)
(define-prefix-command 'lorg-location-map)
(define-prefix-command 'lorg-activation-map)
(define-prefix-command 'lorg-done-map)

(add-hook 'org-mode-hook
	  '(lambda ()
	     (define-key org-mode-map "\C-cn" 'lorg-map)))

(define-key lorg-map "u" 'lorg-update-map)
(define-key lorg-map "i" 'lorg-id-map)
(define-key lorg-map "r" 'lorg-reset-map)
(define-key lorg-map "c" 'lorg-condition-map)
(define-key lorg-map "p" 'lorg-properties-inheritance-map)
(define-key lorg-map "l" 'lorg-link-map)
(define-key lorg-map "L" 'lorg-location-map)
(define-key lorg-map "a" 'lorg-activation-map)

(define-key lorg-map "P" 'lorg-git-and-mobile-push)
(define-key lorg-map "g" 'lorg-recurring-toggle)
(define-key lorg-map "d" 'lorg-done-entry)
(define-key lorg-condition-map "s" 'lorg-store-condition-id)
(define-key lorg-condition-map "i" 'lorg-set-condition-id)
(define-key lorg-condition-map "t" 'lorg-set-condition-type)
(define-key lorg-id-map "e" 'lorg-set-id)
(define-key lorg-id-map "a" 'lorg-set-all-id)
(define-key lorg-reset-map "e" 'lorg-reset-entry)
(define-key lorg-reset-map "s" 'lorg-reset-subtree)
(define-key lorg-update-map "e" 'lorg-update-entry)
(define-key lorg-update-map "s" 'lorg-update-subtree)
(define-key lorg-update-map "a" 'lorg-update-all)
(define-key lorg-properties-inheritance-map "s" 'lorg-set-subtree-properties)
(define-key lorg-link-map "s" 'lorg-store-link)
(define-key lorg-link-map "i" 'lorg-insert-link)
(define-key lorg-location-map "s" 'lorg-store-location)
(define-key lorg-location-map "i" 'lorg-set-location)
(define-key lorg-location-map "v" 'lorg-visit-location)
(define-key lorg-location-map "e" 'lorg-location-examine-contents)
(define-key lorg-activation-map "e" 'lorg-activate-entry)
(define-key lorg-activation-map "s" 'lorg-activate-subtree)


;; lorg bindings for agenda mode
(define-prefix-command 'lorg-agenda-map)
(define-prefix-command 'lorg-agenda-condition-map)
(define-prefix-command 'lorg-agenda-update-map)
(define-prefix-command 'lorg-agenda-id-map)
(define-prefix-command 'lorg-agenda-reset-map)
(define-prefix-command 'lorg-agenda-properties-inheritance-map)
(define-prefix-command 'lorg-agenda-link-map)
(define-prefix-command 'lorg-agenda-location-map)
(define-prefix-command 'lorg-agenda-activation-map)
(define-prefix-command 'lorg-agenda-done-map)

(require 'org-agenda)
(add-hook 'org-agenda-mode-hook
	  '(lambda ()
	     (define-key org-agenda-mode-map "\C-cn" 'lorg-agenda-map)))

(define-key lorg-agenda-map "u" 'lorg-agenda-update-map)
(define-key lorg-agenda-map "i" 'lorg-agenda-id-map)
(define-key lorg-agenda-map "r" 'lorg-agenda-reset-map)
(define-key lorg-agenda-map "c" 'lorg-agenda-condition-map)
(define-key lorg-agenda-map "p" 'lorg-agenda-properties-inheritance-map)
(define-key lorg-agenda-map "l" 'lorg-agenda-link-map)
(define-key lorg-agenda-map "L" 'lorg-agenda-location-map)
(define-key lorg-agenda-map "a" 'lorg-agenda-activation-map)

;;lorg (agenda mode) keybindings
(define-key lorg-agenda-map "P" '(lambda () (interactive) (lorg-modified-org-agenda-goto)(lorg-git-and-mobile-push)))
(define-key lorg-agenda-map "g" '(lambda () (interactive) (lorg-modified-org-agenda-goto)(lorg-recurring-toggle)))
(define-key lorg-agenda-map "d" '(lambda () (interactive) (lorg-modified-org-agenda-goto)(lorg-done-entry)))

;; lorg condition (agenda mode) keybindings
(define-key lorg-agenda-condition-map "s" '(lambda () (interactive) (lorg-modified-org-agenda-goto)(lorg-store-condition-id)))
(define-key lorg-agenda-condition-map "i" '(lambda () (interactive) (lorg-modified-org-agenda-goto)(lorg-set-condition-id)))
(define-key lorg-agenda-condition-map "t" '(lambda () (interactive) (lorg-modified-org-agenda-goto)(lorg-set-condition-type)))

;; lorg id (agenda mode) keybindings
(define-key lorg-agenda-id-map "e" '(lambda () (interactive) (lorg-modified-org-agenda-goto)(lorg-set-id)))
(define-key lorg-agenda-id-map "a" '(lambda () (interactive) (lorg-modified-org-agenda-goto)(lorg-set-all-id-subtree)))

;; lorg reset (agenda mode) keybindings
(define-key lorg-agenda-reset-map "e" '(lambda () (interactive) (lorg-modified-org-agenda-goto)(lorg-reset-entry)))
(define-key lorg-agenda-reset-map "s" '(lambda () (interactive) (lorg-modified-org-agenda-goto)(lorg-reset-subtree)))

;; lorg update (agenda mode) keybindings
(define-key lorg-agenda-update-map "e" '(lambda () (interactive) (lorg-modified-org-agenda-goto)(lorg-update-entry)))
(define-key lorg-agenda-update-map "s" '(lambda () (interactive) (lorg-modified-org-agenda-goto)(lorg-update-subtree)))
(define-key lorg-agenda-update-map "a" '(lambda () (interactive) (lorg-modified-org-agenda-goto)(lorg-update-all)))

;; lorg properities inheritance (agenda mode) keybindings
(define-key lorg-agenda-properties-inheritance-map "s" '(lambda () (interactive) (lorg-modified-org-agenda-goto)(lorg-set-subtree-properties)))

;; lorg link (agenda mode) keybindings
(define-key lorg-agenda-link-map "s" '(lambda () (interactive) (lorg-modified-org-agenda-goto)(lorg-store-link)))
(define-key lorg-agenda-link-map "i" '(lambda () (interactive) (lorg-modified-org-agenda-goto)(lorg-insert-link)))

;; lorg location (agenda mode) keybindings
(define-key lorg-agenda-location-map "s" '(lambda () (interactive) (lorg-modified-org-agenda-goto)(lorg-store-location)))
(define-key lorg-agenda-location-map "i" '(lambda () (interactive) (lorg-modified-org-agenda-goto)(lorg-set-location)))
(define-key lorg-agenda-location-map "v" '(lambda () (interactive) (lorg-modified-org-agenda-goto)(lorg-visit-location)))
(define-key lorg-agenda-location-map "e" '(lambda () (interactive) (lorg-modified-org-agenda-goto)(lorg-location-examine-contents)))

;; lorg activation (agenda mode) keybindings
(define-key lorg-agenda-activation-map "e" '(lambda () (interactive) (lorg-modified-org-agenda-goto)(lorg-activate-entry)))
(define-key lorg-agenda-activation-map "s" '(lambda (arg) (interactive "p") (lorg-modified-org-agenda-goto)(lorg-activate-subtree arg)))



