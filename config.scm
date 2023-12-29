;; This is an operating system configuration generated
;; by the graphical installer.
;;
;; Once installation is complete, you can learn and modify
;; this file to tweak the system configuration, and pass it
;; to the 'guix system reconfigure' command to effect your
;; changes.


;; Indicate which modules to import to access the variables
;; used in this configuration.
(use-modules (gnu) (gnu system nss))
(use-service-modules cups desktop networking ssh xorg)
(use-package-modules bootloaders certs emacs emacs-xyz ratpoison suckless wm
                     xorg)

;; Import nonfree linux module.
(use-modules (nongnu packages linux)
             (nongnu system linux-initrd))

(operating-system
  (locale "en_US.utf8")
  (timezone "Asia/Shanghai")
  (keyboard-layout (keyboard-layout "us"))
  (host-name "guix-test")

  ;; Using the standard Linux kernel and nonfree firmware
  (kernel linux)
  (initrd microcode-initrd)
  (firmware (list linux-firmware))

  ;; The list of user accounts ('root' is implicit).
  (users (cons* (user-account
                  (name "ryan")
                  (comment "Ryan")
                  (group "users")
                  (home-directory "/home/ryan")
                  (supplementary-groups '("wheel" "netdev" "audio" "video")))
                %base-user-accounts))

  ;; Packages installed system-wide.  Users can also install packages
  ;; under their own account: use 'guix search KEYWORD' to search
  ;; for packages and 'guix install PACKAGE' to install a package.
  ;; Add a bunch of window managers; we can choose one at
  ;; the log-in screen with F1.
  (packages (append (list
                     ;; window managers
                     ratpoison i3-wm i3status dmenu
                     emacs emacs-exwm emacs-desktop-environment
                     make neovim git kitty ncurses-with-tinfo
                    ;; terminal emulator
                     xterm
                     ;; for HTTPS access
                     nss-certs)
                    %base-packages))

  ;; Below is the list of system services.  To search for available
  ;; services, run 'guix system search KEYWORD' in a terminal.
  (services
   (append
    (list
      ;; To configure OpenSSH, pass an 'openssh-configuration'
      ;; record as a second argument to 'service' below.
      (service openssh-service-type)

      (set-xorg-configuration
       (xorg-configuration (keyboard-layout keyboard-layout))))

      ;; This is the default list of services we
      ;; Using the substitute server of SJTU to speed up the download.
      (modify-services %desktop-services
      	(guix-service-type
      	 config => (guix-configuration
      	(inherit config)
      	(substitute-urls '("https://mirror.sjtu.edu.cn/guix/" "https://ci.guix.gnu.org")))))))

  (bootloader (bootloader-configuration
                (bootloader grub-bootloader)
                (targets (list "/dev/sda"))
                (keyboard-layout keyboard-layout)))
  (initrd-modules (append '("virtio_scsi") %base-initrd-modules))
  (swap-devices (list (swap-space
                        (target (uuid
                                 "c1345797-6772-4d43-81a4-e7a710fec820")))))

  ;; The list of file systems that get "mounted".  The unique
  ;; file system identifiers there ("UUIDs") can be obtained
  ;; by running 'blkid' in a terminal.
  (file-systems (cons* (file-system
                         (mount-point "/boot/efi")
                         (device (uuid "3F67-100B"
                                       'fat16))
                         (type "vfat"))
                       (file-system
                         (mount-point "/")
                         (device (uuid
                                  "7e92e417-62ef-49fe-878d-dabf7da3a68e"
                                  'ext4))
                         (type "ext4")) %base-file-systems)))
