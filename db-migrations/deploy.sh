#!/bin/bash
docker build -t [your_db_migration_image] .
docker push [your_db_migration_image]

ssh [gcp_username]@[server_ip_address] << EOF
docker pull [your_db_migration_image]:latest
# stop and remove a container
# '|| true' - allows us to ignore any error during the execution of command and proceed
docker run --net [network_name] --rm [your_db_migration_image] || true
# remove all images
docker rmi [your_db_migration_image]
EOF
