# docker image ansible-deploy

A lightweight Docker image based on Alpine Linux for Ansible automation. Ideal for CI/CD pipelines.

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

- `ansible.posix`
- `community.crypto`
- `community.docker`
- `community.general`
- `devsec.hardening`

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
