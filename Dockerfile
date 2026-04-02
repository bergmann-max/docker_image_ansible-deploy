FROM alpine:3.23@sha256:25109184c71bdad752c8312a8623239686a9a2071e8825f20acb8f2198c3f659
ENV PIP_NO_CACHE_DIR=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    ANSIBLE_COLLECTIONS_PATH=/home/ansible/.ansible/collections \
    ANSIBLE_HOST_KEY_CHECKING=False

RUN apk add --no-cache \
    python3 py3-pip openssh-client git \
    sshpass rsync gnupg curl wget jq \
    && pip install --no-cache-dir --break-system-packages \
    ansible-core ansible-lint mitogen netaddr jmespath \
    && adduser -D -u 1000 ansible \
    && mkdir -p /home/ansible/.ansible/collections /ansible \
    && chown -R ansible:ansible /home/ansible /ansible

USER ansible

RUN ansible-galaxy collection install \
    ansible.posix \
    community.crypto \
    community.docker \
    community.general \
    devsec.hardening \
    && find "${ANSIBLE_COLLECTIONS_PATH}" \
    \( -name "*.tar.gz" -o -name "*.zip" -o -name "*.pyc" -o -name "*.pyo" \) -delete \
    && find "${ANSIBLE_COLLECTIONS_PATH}" \
    -type d \( -name tests -o -name docs -o -name changelogs -o -name .github \) \
    -prune -exec rm -rf '{}' + \
    && rm -rf /home/ansible/.ansible/tmp /home/ansible/.cache

WORKDIR /ansible

CMD ["sh"]
