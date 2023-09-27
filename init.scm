(require-builtin helix/core/static as helix.static.)
(require-builtin helix/core/typable as helix.)

(require "cogs/keymaps.scm")
(require "cogs/recentf-mode.scm")
(helix.theme *helix.cx* '("kanagawa") helix.PromptEvent::Validate)

;(recentf-snapshot *helix.cx*)
