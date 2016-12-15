#/bin/bash
#script checks DRBD status on a host
drbd_status=`/sbin/drbdsetup status |sed -n '1 p'|cut -d : -f2`
if [ $drbd_status ];then
  if [ $drbd_status=='Primary' ] || [ $drbd_status=='Secondary' ]; then
    echo $drbd_status;
    exit 0;
  fi
  else
    echo 'unknown DRBD status, please verify DRBD service is functioning properly';
    exit 0;
fi
