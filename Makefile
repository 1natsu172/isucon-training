.PHONY: setup
setup:
	git clone -b tweak-for-docker https://github.com/middle-age-dancing/ansible-isucon.git && \
	make ansible-play

.PHONY: ansible-play
ansible-play:
	cd ansible-isucon/isucon11-qualifier && \
	ansible-playbook -i standalone.hosts --connection=local site.yml
