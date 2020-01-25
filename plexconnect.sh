#!/bin/bash
# Check if existing config file exist, if so will use it.
  
 echo "*** Check if previous config exist, if so will use it..."  
  if [ -f /config/Settings.cfg ]; then   
    cp /config/Settings.cfg /opt/PlexConnect/Settings.cfg
  else
    /usr/bin/python /opt/PlexConnect/Settings.py 
  fi

 echo "*** Check if previous ATVconfig exist, if so will use it..."  
  if [ -f /config/ATVSettings.cfg ]; then   
    cp /config/ATVSettings.cfg /opt/PlexConnect/ATVSettings.cfg
  else
    echo "*** Copy Done."
  fi

# Run the PlexConnect  
echo "*** Launching PlexConnect..."
exec /usr/bin/python /opt/PlexConnect/PlexConnect.py
