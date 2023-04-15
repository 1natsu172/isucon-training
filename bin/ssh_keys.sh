#!/usr/bin/env bash
set -euo pipefail

script_path=$(
  cd "$(dirname ${BASH_SOURCE:-$0})"
  pwd
)

project_root_path=$(
  cd ${script_path}/../
  pwd
)

SSH_DIR="${HOME}/.ssh"
KEY_NAME="isucon-training"
PRIVATE_KEY="${SSH_DIR}/${KEY_NAME}"
PUBLIC_KEY="${SSH_DIR}/${KEY_NAME}.pub"

generate_ssh_key_if_not_exists() {
  # Create the ~/.ssh directory if it does not exist
  mkdir -p "${SSH_DIR}"

  if [ ! -f "${PRIVATE_KEY}" ] || [ ! -f "${PUBLIC_KEY}" ]; then
    echo "SSH key '${KEY_NAME}' not found in ${SSH_DIR}. Generating a new key..."
    ssh-keygen -t rsa -b 4096 -C "${KEY_NAME}" -f "${PRIVATE_KEY}" -N ""
    echo "SSH key '${KEY_NAME}' has been generated in ${SSH_DIR}."
  else
    echo "SSH key '${KEY_NAME}' already exists in ${SSH_DIR}."
  fi
}

copy_pub_key() {
  cp ${PUBLIC_KEY} ${project_root_path}/authorized_keys
}
