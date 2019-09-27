#!/bin/bash
# Docker Entrypoint script.
# Start the ssh server
/etc/init.d/ssh restart
echo "Welcome to Docker Container with Ansible running!"
# Execute the CMD
exec "$@"
