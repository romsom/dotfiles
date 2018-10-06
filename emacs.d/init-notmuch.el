(require 'notmuch)

(setq notmuch-search-oldest-first nil
      message-sendmail-envelope-from 'header
      mail-specify-envelope-from 'header
      mail-envelope-from 'header
      ;; notmuch-show-all-multipart/alternative-parts nil
      mime-edit-pgp-signers '("6C5C7954D5D9CA9B1B7E1F122483A9F8C8E35619")
      mime-edit-pgp-encrypt-to-self t
      mml2015-encrypt-to-self t
      mml2015-sign-with-sender t
      notmuch-crypto-process-mime t
      message-send-mail-function 'message-send-mail-with-sendmail
      sendmail-program "msmtp"
      message-sendmail-f-is-evil nil
      mail-interactive t
      user-full-name "Roman Sommer"
      user-mail-address "Roman Sommer <roman.sommer@fau.de>"
      message-kill-buffer-on-exit t
      mail-user-agent 'message-user-agent
      notmuch-always-prompt-for-sender t
      ;; notmuch-fcc-dirs '((".*" . "Defunct/Sent"))
      notmuch-show-indent-messages-width 4)
