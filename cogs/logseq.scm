(require-builtin helix/core/typable as helix.)
(require-builtin helix/core/static as helix.static.)
(require-builtin helix/core/editor)

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

(define VAULT (expand-path "~/vaults/selfy"))

;;@doc
;; Searches through `VAULT` for a note using a Picker.
(define (find-note cx)
  (helix.open cx (list VAULT) helix.PromptEvent::Validate))

;;@doc
;; Search through your `VAULT` in search for a word/tag.
(define (search-in-note cx)
  (helix.static.search-in-directory cx VAULT))

;;@doc
;; Opens the daily note in your vault
(define (open-daily-note cx)
  (helix.open cx (list (string-append VAULT "/journals/2023_10_09.md")) helix.PromptEvent::Validate))

(provide find-note
         ; create-note
         search-in-note
         open-daily-note)

