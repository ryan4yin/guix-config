# just(Justfile) is a task runner similar to gnumake(Makefile), but simpler

sys:
  sudo guix system reconfigure ./system.scm --load-path=./modules

home:
  guix home reconfigure ./home.scm --load-path=./modules

pull:
  echo "Pulling all channel's git repositories..."
  echo "Based on the gap between the current commit and the latest commit of guix's official repo, this operation may take a while..."
  guix pull --channels=.guix-channels
  guix describe --format=channels > .guix-channels.lock
