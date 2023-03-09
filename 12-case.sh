#!/bin/bash 

# Syntan for CASE 
# case  $var in 
#     opt1) command1 ;; 
     
#     opt2) command2 ;;

# esac

ACTION=$1

case $ACTION in 

    start) 
        echo "Starting Payment Service"
        ;; 
    stop)
        echo "Stopping Payment Service"
        ;;
    restart)
        echo "Restarting Payment Service"        
        ;;
esac 