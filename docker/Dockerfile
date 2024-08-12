FROM ubuntu:latest

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Seoul
ENV PYTHON_VERSION=3.11

RUN apt-get update && apt-get install -qq -y \
    build-essential tzdata vim wget curl net-tools python3-pip sudo git ca-certificates \
    && apt-get clean && rm -rf /var/lib/apt/lists/* \
    && wget -q https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /tmp/miniconda.sh \
    && bash /tmp/miniconda.sh -b -u -p /opt/conda \
    && rm /tmp/miniconda.sh \
    && git config --global init.defaultBranch main

ENV PATH="/opt/conda/bin:$PATH"

WORKDIR /opt

COPY .env ./
COPY entrypoint.sh /usr/local/bin/

RUN export $(cat .env | xargs) \
    && chmod +x /usr/local/bin/entrypoint.sh \
    && conda init bash \
    && . "/opt/conda/etc/profile.d/conda.sh" \
    && conda create -n dizest python=$PYTHON_VERSION -y \
    && conda activate dizest \
    && if [ -z ${DIZEST_VERSION+x} ]; then pip install dizest; else pip install dizest==$DIZEST_VERSION; fi \
    && dizest install dizest

EXPOSE 4000

CMD ["entrypoint.sh"]