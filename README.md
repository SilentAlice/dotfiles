SilentAlice's dotfile

mutt config

1. My mutt used mutt-colors-solarized colors, which is managed as submodule.
  Update submodule after you clone this.

2. Add some highlight to support in-place git patch review.

### Usage

1. Clone this 

  ```
  git clone --single-branch -b mutt https://github.com/SilentAlice/dotfiles ~/.mutt
  cd ~/.mutt
  git submodule update --init
  cp .muttrc ~/
  ```

2. Using SMTP: Modify ~/.muttrc :

  ```
  Account Setting
  set realname = "Your Display Name"
  set from = "your_from_email@example.com"
  set use_from = yes
  # Set it if you want to change header to different mail address
  # my_hrd From: "dispaly_email@example.com"
  
  ## Setting for gmail ##
  set imap_user = "imap user name"
  #set imap_pass = "passwd to login directly"
  
  # Remote folder; When using imap protocal,
  # we can retrive remote folder directly.
  # This setting will override the folder variable above
  set folder = "imaps://imap.gmail.com:993"
  # You can specify "+INBOX/Filted" and let your mutt only open these filted mails-
  # (e.g. patches).
  set spoolfile = "+INBOX"
  mailboxes = +INBOX
  set postponed = "+[Gmail]/Drafts"
  ```
  
  If you dont use imap protocal, the mail will be received to ~/Mail/,
  you can specify a receiving program.

3. `set certificate_file` = ~/path/to/cert

  imap need to verify server certificate, to get certificate:

  ```
  openssl s_client -showcerts -connect imap.example.com:993
  ```

  You will get server reply with its certificate.
  Copy it into one file and specify it in your `.muttrc`

