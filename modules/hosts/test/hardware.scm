(define-module (hosts test hardware)
  #:use-module (gnu bootloader)
  #:use-module (gnu bootloader grub)
  #:use-module (gnu system file-systems)
  #:use-module (gnu system mapped-devices)
  #:re-export (bootloader grub file-systems mapped-devices)
  #:export
  (my-file-systems
   my-bootloader
   my-swap-device))

(define my-file-systems
  (cons* (file-system
          (mount-point "/boot/efi")
          (device (uuid "3F67-100B"
                        'fat16))
          (type "vfat")
          (file-system
           (mount-point "/")
           (device (uuid
                    "7e92e417-62ef-49fe-878d-dabf7da3a68e"
                    'ext4))
           (type "ext4"))
          %base-file-systems)))

(define my-bootloader
  (bootloader-configuration
   (bootloader grub-bootloader)
   (targets (list "/dev/sda"))
   (keyboard-layout keyboard-layout)))


(define my-swap-device
  (list (swap-space
         (target (uuid
                  "c1345797-6772-4d43-81a4-e7a710fec820")))))
