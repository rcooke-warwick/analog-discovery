#!/bin/sh


echo "Starting jupyter notebook..."

cp analogue-example.ipynb /data
cp digital-example.ipynb /data
cd /data
jupyter notebook --ip=0.0.0.0 --port=8888 --allow-root --no-browser --NotebookApp.token='' --NotebookApp.password='' &
supervisord -c /etc/supervisor/supervisord_np.conf  
