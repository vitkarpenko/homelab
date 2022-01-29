#!/bin/bash

if ! command -v borgbackup &> /dev/null
then
    sudo apt install borgbackup
fi

if ! command -v rclone &> /dev/null
then
    sudo apt install rclone
fi

export BORG_REPO=/data/backup

echo "Starting backup"

borg create                         \
    --verbose                       \
    --filter AME                    \
    --list                          \
    --stats                         \
    --show-rc                       \
    --compression lz4               \
    ::'{now}'            \
    /home/vitkarpenko/homelab

info "Pruning repository"

borg prune                          \
    --list                          \
    --show-rc                       \
    --keep-daily    7               \
    --keep-weekly   4               \
    --keep-monthly  6               \
