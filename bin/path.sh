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

echo ${script_path}
echo ${project_root_path}
