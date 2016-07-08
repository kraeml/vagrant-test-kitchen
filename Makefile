ansible-galaxy:
	ansible-galaxy install --role-file=requirements.yml

reload:
	vagrant reload --provision-with ansible_local
