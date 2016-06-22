(require 'package)
;; set package-archives, add melpa and marmalade, replace gnu url with https version
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))

;; initialize package mode
;; not needed according to https://www.emacswiki.org/emacs/ELPA,
;; but require latex-preview-pane complains without it
(package-initialize)
