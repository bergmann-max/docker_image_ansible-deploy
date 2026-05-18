FROM alpine:3.23@sha256:5b10f432ef3da1b8d4c7eb6c487f2f5a8f096bc91145e68878dd4a5019afde11
ENV PIP_NO_CACHE_DIR=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    ANSIBLE_COLLECTIONS_PATH=/home/ansible/.ansible/collections \
    ANSIBLE_HOST_KEY_CHECKING=False

COPY requirements.txt /tmp/requirements.txt

RUN apk add --no-cache \
    python3 py3-pip openssh-client git \
    sshpass rsync gnupg curl wget jq \
    && pip install --no-cache-dir --break-system-packages -r /tmp/requirements.txt \
    && rm /tmp/requirements.txt \
    && adduser -D -u 1000 ansible \
    && mkdir -p /home/ansible/.ansible/collections /ansible \
    && chown -R ansible:ansible /home/ansible /ansible

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

CMD ["sh"]
