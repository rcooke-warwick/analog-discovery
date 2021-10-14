#!/bin/sh
echo "Starting jupyter notebook..."

HASH=$(python3 -c 'import os; from notebook.auth import passwd; print(passwd(os.environ.get("PASSWORD"))) if os.environ.get("PASSWORD") else print("")')

cp -r examples /data && cd /data
jupyter notebook --ip=0.0.0.0 --port=8888 --allow-root --no-browser --NotebookApp.token='' --NotebookApp.password=${HASH} &
cd /tmp && supervisord -c /etc/supervisor/supervisord.conf  
