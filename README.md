# docker image ansible-deploy

[![Stable Release](https://img.shields.io/docker/v/maxbergmann/ansible-deploy?sort=semver&logo=docker&logoColor=white&label=stable&color=0077B6)](https://hub.docker.com/r/maxbergmann/ansible-deploy/tags)
[![Docker Image Size](https://img.shields.io/docker/image-size/maxbergmann/ansible-deploy/latest?logo=docker&logoColor=white&label=size&color=0077B6)](https://hub.docker.com/r/maxbergmann/ansible-deploy)
[![Docker Pulls](https://img.shields.io/docker/pulls/maxbergmann/ansible-deploy?logo=docker&logoColor=white&color=0077B6)](https://hub.docker.com/r/maxbergmann/ansible-deploy)
[![Platform](https://img.shields.io/badge/platform-linux%2Farm64-0077B6?logo=arm&logoColor=white)](https://hub.docker.com/r/maxbergmann/ansible-deploy/tags)
[![ansible-core](https://img.shields.io/static/v1?label=ansible-core&message=2.20.5&color=red&logo=ansible&logoColor=white)](https://pypi.org/project/ansible-core/)
[![ansible-lint](https://img.shields.io/static/v1?label=ansible-lint&message=26.4.0&color=yellow&logo=ansible&logoColor=white)](https://pypi.org/project/ansible-lint/)
[![License](https://img.shields.io/badge/license-Unlicense-blue)](LICENSE)

A lightweight Docker image based on Alpine Linux for Ansible automation. Ideal for CI/CD pipelines.

**Platform:** `linux/arm64`

## Included Tools

- `ansible-core`
- `ansible-lint`
- `mitogen`
- `netaddr`
- `jmespath`
- **system tools:**
  - `openssh-client`
  - `git`
  - `sshpass`
  - `rsync`
  - `gnupg`
  - `curl`
  - `wget`
  - `jq`

## Included Collections

- [`ansible.posix`](https://galaxy.ansible.com/ui/repo/published/ansible/posix/) ![v](https://img.shields.io/badge/dynamic/yaml?url=https://raw.githubusercontent.com/bergmann-max/docker_image_ansible-deploy/main/requirements.yml&query=$.collections[0].version&label=&color=blue)
- [`community.crypto`](https://galaxy.ansible.com/ui/repo/published/community/crypto/) ![v](https://img.shields.io/badge/dynamic/yaml?url=https://raw.githubusercontent.com/bergmann-max/docker_image_ansible-deploy/main/requirements.yml&query=$.collections[1].version&label=&color=blue)
- [`community.docker`](https://galaxy.ansible.com/ui/repo/published/community/docker/) ![v](https://img.shields.io/badge/dynamic/yaml?url=https://raw.githubusercontent.com/bergmann-max/docker_image_ansible-deploy/main/requirements.yml&query=$.collections[2].version&label=&color=blue)
- [`community.general`](https://galaxy.ansible.com/ui/repo/published/community/general/) ![v](https://img.shields.io/badge/dynamic/yaml?url=https://raw.githubusercontent.com/bergmann-max/docker_image_ansible-deploy/main/requirements.yml&query=$.collections[3].version&label=&color=blue)
- [`devsec.hardening`](https://galaxy.ansible.com/ui/repo/published/devsec/hardening/) ![v](https://img.shields.io/badge/dynamic/yaml?url=https://raw.githubusercontent.com/bergmann-max/docker_image_ansible-deploy/main/requirements.yml&query=$.collections[4].version&label=&color=blue)

## Usage

```bash
docker pull maxbergmann/ansible-deploy:latest
```

Run a playbook:

```bash
docker run --rm -v $(pwd):/ansible maxbergmann/ansible-deploy:latest ansible-playbook site.yml
```

## Build & Push

```bash
docker buildx build --push \
  -t maxbergmann/ansible-deploy:1.0 \
  -t maxbergmann/ansible-deploy:latest \
  .
```

## CI/CD Example (Actions)

```yaml
jobs:
  ansible:
    runs-on: ubuntu-latest
    container:
      image: maxbergmann/ansible-deploy:latest
    steps:
      - name: Run Ansible Playbook
        run: ansible-playbook site.yml -v
```
