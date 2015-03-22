#!/bin/bash

agent_sock=$(find /tmp/ssh-* -user ${USER} -type s 2> /dev/null)
agent_pid=$(pgrep -u ${USER} '^ssh-agent$')

if [ "${agent_sock}" == "" ]
then
    ssh-agent | grep -v "Agent pid"
else
    echo "SSH_AUTH_SOCK=$agent_sock; export SSH_AUTH_SOCK"
    echo "SSH_AGENT_PID=$agent_pid; export SSH_AGENT_PID"
fi
