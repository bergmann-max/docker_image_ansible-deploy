FROM alpine:3.24@sha256:a2d49ea686c2adfe3c992e47dc3b5e7fa6e6b5055609400dc2acaeb241c829f4

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION=dev
ARG ANSIBLE_UID=1000
ARG ANSIBLE_GID=1000

LABEL org.opencontainers.image.created="${BUILD_DATE}" \
      org.opencontainers.image.authors="Max Bergmann <maxbergmann@mailbox.org>" \
      org.opencontainers.image.url="https://hub.docker.com/r/maxbergmann/ansible-deploy" \
      org.opencontainers.image.documentation="https://github.com/bergmann-max/docker_image_ansible-deploy/blob/main/README.md" \
      org.opencontainers.image.source="https://github.com/bergmann-max/docker_image_ansible-deploy" \
      org.opencontainers.image.version="${VERSION}" \
      org.opencontainers.image.revision="${VCS_REF}" \
      org.opencontainers.image.vendor="Max Bergmann" \
      org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.title="ansible-deploy" \
      org.opencontainers.image.description="Alpine-based Ansible image for CI/CD pipelines. Non-root, pre-installed collections." \
      org.opencontainers.image.base.name="docker.io/library/alpine:3.23"

ENV PIP_NO_CACHE_DIR=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    VIRTUAL_ENV=/opt/venv \
    PATH=/opt/venv/bin:$PATH \
    ANSIBLE_COLLECTIONS_PATH=/home/ansible/.ansible/collections \
    ANSIBLE_HOST_KEY_CHECKING=False

HEALTHCHECK --interval=30s CMD ansible --version

RUN apk add --no-cache \
    python3 py3-pip ca-certificates openssh-client git \
    sshpass rsync gnupg curl jq \
    && python3 -m venv "${VIRTUAL_ENV}" \
    && addgroup -g "${ANSIBLE_GID}" ansible \
    && adduser -D -u "${ANSIBLE_UID}" -G ansible \
       -s /bin/sh -h /home/ansible ansible \
    && mkdir -p /home/ansible/.ansible/collections /ansible \
    && chown -R ansible:ansible /home/ansible /ansible

COPY requirements.txt /tmp/requirements.txt

RUN "${VIRTUAL_ENV}/bin/pip" install --no-cache-dir -r /tmp/requirements.txt \
    && rm /tmp/requirements.txt

COPY --chown=ansible:ansible requirements.yml /home/ansible/requirements.yml

USER ansible

RUN ansible-galaxy collection install -r /home/ansible/requirements.yml \
    && find "${ANSIBLE_COLLECTIONS_PATH}" \
    \( -name "*.tar.gz" -o -name "*.zip" -o -name "*.pyc" -o -name "*.pyo" \) -delete \
    && find "${ANSIBLE_COLLECTIONS_PATH}" \
    -type d \( -name tests -o -name docs -o -name changelogs -o -name .github \) \
    -prune -exec rm -rf '{}' + \
    && rm -rf /home/ansible/.ansible/tmp /home/ansible/.cache

WORKDIR /ansible

CMD ["ansible", "--version"]
