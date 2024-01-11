# just(Justfile) is a task runner similar to gnumake(Makefile), but simpler

deploy: 
  sudo guix system reconfigure ./config.scm

pull:
  echo "Pulling all channel's git repositories..."
  echo "Based on the gap between the current commit and the latest commit of guix's official repo, this operation may take a while..."
  guix pull --channels=./channels.scm
  guix describe --format=channels > ./channels-lock.scm
