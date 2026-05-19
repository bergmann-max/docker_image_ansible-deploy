# docker image ansible-deploy

[![Stable Release](https://img.shields.io/docker/v/maxbergmann/ansible-deploy?arch=arm64&sort=semver&logo=docker&logoColor=white&label=stable&color=green&style=for-the-badge&cacheSeconds=300)](https://hub.docker.com/r/maxbergmann/ansible-deploy/tags)
[![Docker Image Size](https://img.shields.io/docker/image-size/maxbergmann/ansible-deploy/latest?arch=arm64&logo=docker&logoColor=white&label=size&color=1D63ED&style=for-the-badge&cacheSeconds=300)](https://hub.docker.com/r/maxbergmann/ansible-deploy)
[![Docker Pulls](https://img.shields.io/docker/pulls/maxbergmann/ansible-deploy?logo=docker&logoColor=white&color=1D63ED&style=for-the-badge)](https://hub.docker.com/r/maxbergmann/ansible-deploy)
[![Platform](https://img.shields.io/badge/platform-linux%2Farm64-0091BD?logo=arm&logoColor=white&style=for-the-badge)](https://hub.docker.com/r/maxbergmann/ansible-deploy/tags)
[![ansible-core](https://img.shields.io/static/v1?label=ansible-core&message=2.20.5&color=EE0000&logo=ansible&logoColor=white&style=for-the-badge)](https://pypi.org/project/ansible-core/)
[![ansible-lint](https://img.shields.io/static/v1?label=ansible-lint&message=26.4.0&color=EE0000&logo=ansible&logoColor=white&style=for-the-badge)](https://pypi.org/project/ansible-lint/)
[![License](https://img.shields.io/badge/license-MIT-blue?style=for-the-badge)](https://github.com/bergmann-max/power-ansible/blob/main/LICENSE)

Alpine-based Ansible image for CI/CD pipelines. Runs as non-root user (ansible, UID 1000) with pre-installed collections.

## Platform:

- `linux/arm64`

## Tags

| Tag | Description |
|-----|-------------|
| `latest` | Latest stable release |
| `1.x.x` | Stable release |
| `dev` | Development build |

## Packages

- `ansible-core`
- `ansible-lint`
- `mitogen`
- `netaddr`
- `jmespath`
- **system tools:** `openssh-client`, `git`, `sshpass`, `rsync`, `gnupg`, `curl`, `jq`

## Collections

| Collection | Version |
| --- | --- |
| [`ansible.posix`](https://galaxy.ansible.com/ui/repo/published/ansible/posix/) | ![v](https://img.shields.io/badge/dynamic/yaml?url=https://raw.githubusercontent.com/bergmann-max/docker_image_ansible-deploy/main/requirements.yml&query=$.collections[0].version&label=&color=green&style=flat-square) |
| [`ansible.utils`](https://galaxy.ansible.com/ui/repo/published/ansible/utils/) | ![v](https://img.shields.io/badge/dynamic/yaml?url=https://raw.githubusercontent.com/bergmann-max/docker_image_ansible-deploy/main/requirements.yml&query=$.collections[1].version&label=&color=green&style=flat-square) |
| [`community.crypto`](https://galaxy.ansible.com/ui/repo/published/community/crypto/) | ![v](https://img.shields.io/badge/dynamic/yaml?url=https://raw.githubusercontent.com/bergmann-max/docker_image_ansible-deploy/main/requirements.yml&query=$.collections[2].version&label=&color=green&style=flat-square) |
| [`community.docker`](https://galaxy.ansible.com/ui/repo/published/community/docker/) | ![v](https://img.shields.io/badge/dynamic/yaml?url=https://raw.githubusercontent.com/bergmann-max/docker_image_ansible-deploy/main/requirements.yml&query=$.collections[3].version&label=&color=green&style=flat-square) |
| [`community.general`](https://galaxy.ansible.com/ui/repo/published/community/general/) | ![v](https://img.shields.io/badge/dynamic/yaml?url=https://raw.githubusercontent.com/bergmann-max/docker_image_ansible-deploy/main/requirements.yml&query=$.collections[4].version&label=&color=green&style=flat-square) |
| [`devsec.hardening`](https://galaxy.ansible.com/ui/repo/published/devsec/hardening/) | ![v](https://img.shields.io/badge/dynamic/yaml?url=https://raw.githubusercontent.com/bergmann-max/docker_image_ansible-deploy/main/requirements.yml&query=$.collections[5].version&label=&color=green&style=flat-square) |

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

## License

[MIT](LICENSE)
