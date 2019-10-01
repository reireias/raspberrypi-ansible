#!/bin/bash

TARGET_DIR="/tmp/motion"

mkdir -p ${TARGET_DIR}
rm "${TARGET_DIR}/*"
while inotifywait -e CREATE ${TARGET_DIR}; do
    file=$(ls -rt ${TARGET_DIR} | tail -n 1)
    gsutil -o 'Credentials:gs_service_key_file=/root/.credentials.json' cp "${TARGET_DIR}/${file}" gs://cat-watcher.appspot.com/ && rm "${TARGET_DIR}/${file}"
done
