(require "../prelude.scm"
         (for-syntax "../prelude.scm"))

(require-helix)

(define (expand-path path)
  (define (with-stdout-piped command)
    (set-piped-stdout! command)
    command)

  (~> (command "fish" (list "-c" (string-append "echo " path)))
      (with-stdout-piped)
      (spawn-process)
      (Ok->value)
      (wait->stdout)
      (Ok->value)
      (trim)))

(define OBSIDIAN-VAULT (expand-path "~/vaults/self"))

;;@doc
;; Searches through `OBSIDIAN-VAULT` for a note using a Picker.
(define (find-note cx)
  (helix.open cx (list OBSIDIAN-VAULT) helix.PromptEvent::Validate))

;;@doc
;; Search through your `OBSIDIAN-VAULT` in search for a word/tag.
(define (search-in-note cx)
  (helix.static.search-in-directory cx OBSIDIAN-VAULT))

(provide find-note
         ; create-note
         search-in-note)
         ; open-daily-note)

