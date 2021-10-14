#!/bin/sh


#echo "Starting jupyter notebook..."

#cp test.ipynb /data
#cd /data
#jupyter notebook --ip=0.0.0.0 --port=8888 --allow-root --no-browser --NotebookApp.token='' --NotebookApp.password=''




echo "STARTING VNC WITHOUT PASSWORD"
supervisord -c /etc/supervisor/supervisord_np.conf  
