#!/bin/bash

agent_sock=$(find /tmp/ssh-* -user ${USER} -type s  | head -n1 2> /dev/null)

if [ "${agent_sock}" == "" ]
then
    ssh-agent | grep -v "Agent pid"
else
    echo "SSH_AUTH_SOCK=$agent_sock; export SSH_AUTH_SOCK"
fi
