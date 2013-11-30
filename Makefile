PLAYBOOK = ltcminers.yml
PEM_FILE = ~/.ssh/aws.pem
INVENTORY = inventory.yml

NUM_INSTANCES = 10
# VERBOSE = -vvvv

run: ansible/ playbook

playbook:
	@sh -c "source ansible/hacking/env-setup > /dev/null && ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook ${PLAYBOOK} -i ${INVENTORY} --private-key ${PEM_FILE} -f ${NUM_INSTANCES} ${VERBOSE}"

ansible/:
	@git clone --depth=1 git://github.com/ansible/ansible.git

clean:
	@rm -rf ansible

.PHONY: run playbook clean
