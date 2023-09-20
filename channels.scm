(list
  ;; packages some non-free software which cannot be included in the official distribution
  (channel
    (name 'nonguix)
    (url "https://github.com/nonguix/nonguix")
    ;; Enable signature verification:
    (introduction
     (make-channel-introduction
      "897c1a470da759236cc11798f4e0a5f7d4d59fbc"
      (openpgp-fingerprint
       "2A39 3FFF 68F4 EF7A 3D29  12AF 6F51 20A0 22FB B2D5"))))
  ;; default guix channel
  ;; https://git.savannah.gnu.org/cgit/guix.git/refs/heads
  (channel
    (inherit (car %default-channels))
    ;; Stay on the version 1.4.0 to avoid too much update
    (branch "version-1.4.0")))

