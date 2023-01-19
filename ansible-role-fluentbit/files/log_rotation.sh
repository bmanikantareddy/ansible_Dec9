#!/bin/bash

# log rotation script for Osqueryd and fluent-bit

log_rotation()
{
    FILE=$1
    FILE_BAK="$1.bak"
    if [ -f "${FILE_BAK}" ]; then
        rm -rf ${FILE_BAK}
    fi

    if [ -f "${FILE}" ]; then
        mv $FILE $FILE_BAK
        echo > $FILE
    fi
}

# OSqueryd log rotation
log_rotation "/var/log/osquery/osqueryd.results.log"
log_rotation "var/log/messages"
# Fluent-bit log rotation
#log_rotation "replace with fluent-bit path"



