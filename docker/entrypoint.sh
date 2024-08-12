#!/bin/bash
set -e

source /opt/conda/etc/profile.d/conda.sh
conda activate dizest
cd /opt/dizest

# 환경 변수로부터 비밀번호를 받아서 설치 스크립트를 실행합니다.
if [ -n "$PASSWORD" ]; then
  dizest password "$PASSWORD"
fi

if [ -z "$PORT" ]; then
  PORT=4000
fi

dizest run --port "$PORT"