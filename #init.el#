;;PACKAGES
(require 'package)
  (add-to-list
   'package-archives
   '("melpa" . "http://melpa.org/packages/")
   t)
(package-initialize)

;; SMEX
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)

;;IDO
(require 'ido)
(ido-mode t)

;;FROM CUSTOMIZE
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-custom-commands
   (quote
    (("0" "Ready to Schedule"
      ((tags "&STATUS=\"active\"&URGENCY>5" nil))
      nil)
     ("9" "Ready to Prioritize"
      ((tags "+STATUS=\"active\"+URGENCY<=5-URGENCY<2" nil))
      nil)
     ("8" "Unactionable + Urgent"
      ((tags "STATUS=\"wait\"-URGENCY<6" nil))
      nil)
     ("`" "Action Baskets"
      ((todo "ACTION!" nil))
      nil)
     ("z" "Meta"
      ((todo "NOTICE|PROCESS"))
      nil)
     ("p" "Pan Am"
      ((tags "+STATUS=\"active\"+LOCATION=\"pan am\"" nil))
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
 '(org-agenda-todo-ignore-scheduled (quote all))
 '(org-columns-default-format "%25ITEM %TODO %6STATUS %3DURATION %URGENCY 6%LOCATION")
 '(org-drawers (quote ("PROPERTIES" "CLOCK" "LOGBOOK" "RESULTS" "NOTES")))
 '(org-global-properties
   (quote
    (("STATUS_ALL" . "\"active\" \"next\" \"wait\" \"done\" \"n\"")
     ("URGENCY_ALL" . "n 1 2 3 4 5 6 7 8 9"))))
 '(org-hide-leading-stars t)
 '(org-indent-mode-turns-off-org-adapt-indentation nil)
 '(org-log-into-drawer t)
 '(org-refile-targets (quote ((org-agenda-files :regexp . "Inbox"))))
 '(org-todo-keywords
   (quote
    ((sequence "PROCESS(p!)" "NOTICE(n!)" "|" "RESOLVED(r!)" "JOURNAL(j)" "INFO(i)")
     (sequence "ACTION!(`)" "ACTION(1)" "BREAKDOWN(2)" "|" "DONE(3!)")
     (sequence "BUTTON(b)" "|")
     (sequence "APPOINTMENT(A)" "|")
     (sequence "WORK(w)" "|"))))
 '(org-use-property-inheritance (quote ("URGENCY" "LOCATION")))
 '(org-yank-folded-subtrees nil))

;;ORG BASICS

(define-key global-map "\C-cc" 'org-capture)
(define-key global-map "\C-ca" 'org-agenda)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-c C-l" 'org-insert-link)

					;local keybindings
(add-hook 'org-mode-hook
	  '(lambda ()
	     (define-key org-mode-map "\M-<RET>" 'org-insert-heading-respect-content)))
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
	  'lorg-set-all-id)

;;ORG CAPTURE

(setq org-capture-templates
      '(("j" "Journal" entry (file+datetree "~/org/journal.org")
	 "* JOURNAL %U\n%?")
	("J" "Journal+" entry (file+datetree "~/org/journal.org")
	 "* JOURNAL %?\n:NOTES:\nCreated: %U\n:END:")
	("p" "Process" entry (file+datetree "~/org/journal.org")
	 "* PROCESS %?\n%i\n:PROPERTIES:\n:STATUS: active\n:URGENCY: 5\n:END:")
	("n" "Notice" entry (file+datetree "~/org/journal.org")
	 "* NOTICE %?\n%i\n:PROPERTIES:\n:STATUS: active\n:URGENCY: 6\n:END:")
	("M" "Main Captures")
	("M`" "Action!" entry (file+headline "~/org/main.org" "Initiatives")
	 "* ACTION! %i%?\n:PROPERTIES:\n:STATUS: active\n:URGENCY: 5\n:END:")
	("M1" "Action" entry (file+headline "~/org/main.org" "Initiatives")
	 "* ACTION %i%?\n:PROPERTIES:\n:STATUS: active\n:URGENCY: 5\n:END:")
	("M2" "Breakdown" entry (file+headline "~/org/main.org" "Initiatives")
	 "* BREAKDOWN %i%?\n:PROPERTIES:\n:STATUS: active\n:URGENCY: 5\n:END:")
	("Mb" "Button" entry (file+headline "~/org/main.org" "Buttons")
	 "* BUTTON %i%?\n:PROPERTIES:\n:PRESSED: nil\n:PRESSED_ALL: t nil\n:COLUMNS: %25ITEM %6TODO %3PRESSED\n:END:")
	("MA" "Appointment" entry (file+headline "~/org/main.org" "Appointments")
	 "* APPOINTMENT %?\n  %i\n")
	("Mi" "Info" entry (file+datetree "~/org/main.org")
	 "* INFO %?\n  %i\n")
	("G" "GORG Captures")
	("G`" "Gorg Action!" entry (file+headline "~/org/gorg.org" "Initiatives")
	 "* ACTION! %i%?\n:PROPERTIES:\n:STATUS: active\n:URGENCY: 5\n:END:")
	("G1" "Gorg Action" entry (file+headline "~/org/gorg.org" "Initiatives")
	 "* ACTION %i%?\n:PROPERTIES:\n:STATUS: active\n:URGENCY: 5\n:END:")
	("G2" "Gorg Breakdown" entry (file+headline "~/org/gorg.org" "Initiatives")
	 "* BREAKDOWN %i%?\n:PROPERTIES:\n:STATUS: active\n:URGENCY: 5\n:END:")
	("Gj" "Gorg Journal" entry (file+datetree "~/org/gorg.org")
	 "* %U\n%?")
	("Gi" "Gorg Info" entry (file+datetree "~/org/gorg.org")
	 "* INFO %?\n%i")
	("W" "Work Captures")
	("W`" "Work Action!" entry (file+headline "~/org/work.org" "Initiatives")
	 "* ACTION %i%?\n:PROPERTIES:\n:STATUS: active\n:URGENCY: 5\n:END:")
	("W1" "Work Action" entry (file+headline "~/org/work.org" "Initiatives")
	 "* ACTION %i%?\n:PROPERTIES:\n:STATUS: active\n:URGENCY: 5\n:END:")
	("W2" "Work Breakdown" entry (file+headline "~/org/work.org" "Initiatives")
	 "* BREAKDOWN %i%?\n:PROPERTIES:\n:STATUS: active\n:URGENCY: 5\n:END:")
	("Wb" "Work Button" entry (file+headline "~/org/work.org" "Buttons")
	 "* BUTTON %i%?\n:PROPERTIES:\n:PRESSED: nil\n:PRESSED_ALL: t nil\n:COLUMNS: %25ITEM %6TODO %3PRESSED\n:END:")
	("Wj" "Work Journal" entry (file+datetree "~/org/work.org")
	 "* %U\n%?")
	("Wi" "Work Info" entry (file+datetree "~/org/work.org")
	 "* INFO %?\n%i")
	("B" "Body Captures")
	("B`" "Body Action!" entry (file+headline "~/org/body.org" "Initiatives")
	 "* ACTION %i%?\n:PROPERTIES:\n:STATUS: active\n:URGENCY: 5\n:END:")
	("B1" "Body Action" entry (file+headline "~/org/body.org" "Initiatives")
	 "* ACTION %i%?\n:PROPERTIES:\n:STATUS: active\n:URGENCY: 5\n:END:")
	("B2" "Body Breakdown" entry (file+headline "~/org/body.org" "Initiatives")
	 "* BREAKDOWN %i%?\n:PROPERTIES:\n:STATUS: active\n:URGENCY: 5\n:END:")
	("Bj" "Body Journal" entry (file+datetree "~/org/body.org")
	 "* %U\n%?")
	("Bi" "Body Info" entry (file+datetree "~/org/body.org")
	 "* INFO %?\n%i")
	("F" "Food Captures")
	("F`" "Food Action!" entry (file+headline "~/org/food.org" "Initiatives")
	 "* ACTION! %i%?\n:PROPERTIES:\n:STATUS: active\n:URGENCY: 5\n:END:")
	("F1" "Food Action" entry (file+headline "~/org/food.org" "Initiatives")
	 "* ACTION %i%?\n:PROPERTIES:\n:STATUS: active\n:URGENCY: 5\n:END:")
	("F2" "Food Breakdown" entry (file+headline "~/org/food.org" "Initiatives")
	 "* BREAKDOWN %i%?\n:PROPERTIES:\n:STATUS: active\n:URGENCY: 5\n:END:")
	("Fb" "Food Button" entry (file+headline "~/org/food.org" "Buttons")
	 "* BUTTON %i%?\n:PROPERTIES:\n:PRESSED: nil\n:PRESSED_ALL: t nil\n:COLUMNS: %25ITEM %6TODO %3PRESSED\n:END:")
	("Fj" "Food Journal" entry (file+datetree "~/org/food.org")
	 "* %U\n%?")
	("Fi" "Food Info" entry (file+datetree "~/org/food.org")
	 "* INFO %?\n%i")))

;;ORG APPEARANCE
(set 'org-startup-indented t)
(setq org-todo-keyword-faces
      '(("NEED" . "purple")("BLUEPRINT" . "blue")("WAIT" . "blue")("NEXT" . "purple")("HOME" . "purple")))

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

(set 'last-lorg-id-number 1182)

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
		(goto-char target-point))
	    (progn
	      (set-buffer target-buffer)
	      (goto-char target-point)))
	nil)))
      
;;LORG CONDITIONS

;getting and setting conditions


(set 'current-condition nil)

(defun lorg-store-id ()
  (interactive nil)
  (set 'current-condition (lorg-get-id))
  (print "Id stored."))

(defun lorg-set-condition-id ()
  "Accepts as argument a string specifying a LORG_ID number.  Stores this LORG_ID as the value of a CONDITION property in the entry at point."
  (interactive nil)
  (org-entry-put (point) "CONDITION" current-condition)
  (print "Condition set."))

;updating entry statuses based on conditions
(defun lorg-test-condition-action ()
  "Accepts no arguments.  Checks the STATUS property of the action or breakdown item at point; if status is 'done', return t, otherwise returns nil."
  (if (equal (org-entry-get (point) "STATUS") "done")
      t
    nil))

(defun lorg-test-condition-button-action!()
  "Accepts no arguments.  Checks and returns the PRESSED property of the button entry at point, or else returns t or nil depending on whether the STATUS property is 'active'."
  (if (equal (org-entry-get (point) "TODO") "BUTTON")
      (org-entry-get (point) "PRESSED")
    (if (equal (org-entry-get (point) "STATUS") "active")
	t
      nil)))
    
(defun lorg-test-condition(id condtyp)
  "Accepts as argument a A) string specifying a LORG_ID, and B) a string specifying the type of condition being tested. B should be either the string 'action' or the string 'button.'  Visits the entry which corresponds to the LORG_ID, and returns a test of that entry appropriate to the condition type passed in."
  (lorg-find-entry-id id nil)
  (if (equal condtyp "next")
      (lorg-test-condition-action)
    (if (equal condtyp "wait")
	(lorg-test-condition-button-action!)
      "Not a valid condition type.")))

(defun lorg-update-status()
  "Accepts no arguments.  Updates the status of the entry at point based on its CONDITION property."
  (interactive nil)
  (let ((condition-id nil)
	(condition-type nil)
	(condition-met nil))
    (set 'condition-id (org-entry-get (point) "CONDITION"))
    (set 'condition-type (if (equal (org-entry-get (point) "STATUS") "next")
			     "next"
			   (if (equal (org-entry-get (point) "STATUS") "wait")
			       "wait"
			     nil)))
    (print (org-entry-get (point) "LORG_ID"))
    (print condition-id)
    (print condition-type)
    (if (and condition-type condition-id)
	(set 'condition-met (save-excursion
			      (lorg-test-condition condition-id condition-type)))
      nil)
    (if condition-met
	(org-entry-put (point) "STATUS" "active")
      nil)))

(defun lorg-update-subtree-statuses()
  "Accepts no arguments.  Updates the status of all org entries in the subtree at point based on their CONDITION."
  (interactive nil)
  (org-map-entries '(lorg-update-status) t 'tree)
  (print "Statuses in tree updated."))

(defun lorg-update-all-statuses()
  "Accepts no arguments.  Updates the status of all org entries based on their CONDITION."
  (interactive nil)
  (org-map-entries '(lorg-update-status) t 'agenda)
  (print "Statuses updated."))

;;LORG KEYBINDINGS

(define-prefix-command 'lorg-map)
(add-hook 'org-mode-hook
	  '(lambda ()
	     (define-key org-mode-map "\C-cn" 'lorg-map)))

(add-hook 'org-agenda-mode-hook
	  '(lambda ()
	     (define-key org-mode-map "\C-cn" 'lorg-map)))

(define-key lorg-map "u" 'lorg-update-all-statuses)
(define-key lorg-map "i" 'lorg-set-id)
(define-key lorg-map "I" 'lorg-set-all-id)
(define-key lorg-map "s" 'lorg-store-id)
(define-key lorg-map "c" 'lorg-set-condition-id)



    


  
  

    

