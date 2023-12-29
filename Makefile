#
#  NOTE: Makefile's target name should not be the same as one of the file or directory in the current directory, 
#    otherwise the target will not be executed!
#


deploy: 
	sudo guix system reconfigure ./config.scm

pull:
	echo "Pulling all channel's git repositories..."
	echo "Based on the gap between the current commit and the latest commit of guix's official repo, this operation may take a while..."
	guix pull --channels=./channels.scm
	# guix describe --format=channels > ./channels.scm

