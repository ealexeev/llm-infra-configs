FROM dhi.io/debian-base:trixie-debian13-dev

COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

RUN apt-get update && apt-get install curl build-essential python3 python3-pip nodejs npm supervisor golang-go rustup procps zsh -y  && rm -rf /var/lib/apt/lists/*
RUN rustup default stable
RUN cargo install htmlq
RUN cp /root/.cargo/bin/htmlq /usr/bin/

RUN groupadd -g 1000 hermes
RUN useradd -s /bin/bash -g hermes -u 1000 -m -d /workspace hermes

# Hermes directories
# Read-only view into the git repo and code.
RUN mkdir /opt/hermes-agent
# Read-write mount for agent work
RUN chown -R hermes:hermes /workspace

USER hermes
# Read-write mount for the stateful directory
RUN mkdir /workspace/.hermes/

USER root
COPY hermes-agent/hermes-gateway.conf /etc/supervisor/conf.d/hermes-gateway.conf
COPY hermes-agent/startup.sh /usr/local/bin/startup.sh
RUN chmod +x /usr/local/bin/startup.sh

ENV PATH="$PATH:/usr/local/go/bin:/opt/hermes-agent/venv/bin"
ENV USER_AGENT="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36"
# Prevent UV from writing to /root/.local/... which is transient
ENV UV_PYTHON_INSTALL_DIR="/opt/hermes-agent/venv_python"

ENTRYPOINT ["/usr/local/bin/startup.sh"]