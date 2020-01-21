(use-package org-cliplink
  :bind
  ("C-c C" . 'jethro/org-capture-link)
  :config
  (defun jethro/org-capture-link ()
    "Captures a link, and stores it in inbox."
    (interactive)
    (org-capture nil "l")))(global-set-key (kbd "C-c l") 'org-store-link)

(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)
(setq org-capture-templates
      '(
        ("i" "inbox" entry (file, "~/k/inbox.org")
         "* TODO %?\n  %i\n  %a")
        ("e" "email" entry (file+headline , "~/k/emails.org" "Emails")
         "* TODO [#A] Reply: %a :@home:@school:" :immediate-finish t)
        ("l" "link" entry (file , "~/k/inbox.org")
           "* TODO %(org-cliplink-capture)" :immediate-finish t)
        ; ("t" "Todo" entry (file+headline "~/k/index.org" "Tasks")
        ;  "* TODO %?\n  %i\n  %a")
        ;        ("c" "Todo" entry (file+headline "~/k/index.org" "Tasks")
        ;         "* TODO %:description\n  %i\n  %a")
        ; See ~/dotfiles/manjaro/org-protocol
        ("c" "org-protocol-capture" entry (file , "~/k/index,org")
         "* TODO [[%:link][%:description]]\n\n %i" :immediate-finish t)
        ; TODO: remove this as I will use Zettelkasten instead
        ("j" "Journal" entry (file+datetree "~/k/journal.org")
         "* %?\nEntered on %U\n  %i\n  %a")))
(define-key global-map (kbd "C-c i")
  (lambda () (interactive) (org-capture nil "i")))
(define-key global-map (kbd "C-c j")
  (lambda () (interactive) (org-capture nil "j")))

; Capture articles https://blog.jethro.dev/posts/capturing_inbox/
(load "server")
(unless (server-running-p) (server-start))
(add-to-list 'load-path "~/k/index.org")
(require 'org-protocol)
