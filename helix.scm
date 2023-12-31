(require-builtin helix/core/typable as helix.)
(require-builtin helix/core/static as helix.static.)
(require-builtin helix/core/editor)

;;@doc
;; Specialized shell implementation, where % is a wildcard for the current file
(define (shell cx . args)
  ;; Replace the % with the current file
  (define expanded (map (lambda (x) (if (equal? x "%") (current-path cx) x)) args))
  (helix.run-shell-command cx expanded helix.PromptEvent::Validate))

;; Functions to assist with the above

(define (editor-get-doc-if-exists editor doc-id)
  (if (editor-doc-exists? editor doc-id) (editor->get-document editor doc-id) #f))

(define (current-path cx)
  (let* ([editor (cx-editor! cx)]
         [focus (editor-focus editor)]
         [focus-doc-id (editor->doc-id editor focus)]
         [document (editor-get-doc-if-exists editor focus-doc-id)])

    (if document (Document-path document) #f)))


;;@doc
;; Reload the helix.scm file
(define (reload-helix-scm cx)
  (helix.static.run-in-engine! cx
                               (string-append "(require \"" (helix.static.get-helix-scm-path) "\")")))

;;@doc
;; Open the helix.scm file
(define (open-helix-scm cx)
  (helix.open cx (list (helix.static.get-helix-scm-path)) helix.PromptEvent::Validate))

;;@doc
;; Run the highlighted Steel text as an expression in the global namespace.
(define (run-highlight cx)
  (helix.static.run-in-engine! cx (helix.static.current-highlighted-text! cx)))

;;@doc
;; Opens the init.scm file
(define (open-init-scm cx)
  (helix.open cx (list (helix.static.get-init-scm-path)) helix.PromptEvent::Validate))

(provide shell open-helix-scm open-init-scm reload-helix-scm run-highlight)

;; Recent files
(require "cogs/recentf-mode.scm")
(provide refresh-files
         flush-recent-files
         recentf-snapshot
         recentf-open-files)
  

;; Notes
(require "cogs/obsidian.scm")
(provide find-note
         search-in-note
         open-daily-note)
	
