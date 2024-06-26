#!/bin/bash

# list all data files
if [ ! -f /tmp/cmip_file_list.txt ]; then
 RSYNC_PASSWORD=useatyourownrisk rsync -vrlpt cmip6ng@atmos.ethz.ch::cmip6-ng > /tmp/cmip_file_list.txt
fi

# select the required files (append to file)
# stack grep commands to filter to the desired level

# evapotranspiration, monthly (mm s-1)
cat /tmp/cmip_file_list.txt | grep "r1i1p1f1_native" | grep "CESM2_historical" | grep "evspsbl_" | grep "mon" cut -d' ' -f5 > download_list.txt

# precipitation, daily
cat /tmp/cmip_file_list.txt | grep "r1i1p1f1_native" | grep "CESM2_historical" | grep "pr_day" | cut -d' ' -f5 > download_list.txt

# temperature, daily
cat /tmp/cmip_file_list.txt | grep "r1i1p1f1_native" | grep "CESM2_historical" | grep "tas_day" | cut -d' ' -f5 >> download_list.txt

# cat /tmp/cmip_file_list.txt | grep "r1i1p1f1_native" | grep "CESM2_historical" | grep "rlds_mon" | cut -d' ' -f8 >> download_list.txt
# cat /tmp/cmip_file_list.txt | grep "r1i1p1f1_native" | grep "CESM2_historical" | grep "rtmt_mon" | cut -d' ' -f8 >> download_list.tx
# cat /tmp/cmip_file_list.txt | grep "r1i1p1f1_native" | grep "CESM2_historical" | grep "tran_mon" | cut -d' ' -f8 >> download_list.txt

cat download_list.txt

# download using the temporary list, into the current directory
SYNC_PASSWORD=useatyourownrisk rsync -vrlpt --files-from=download_list.txt cmip6ng@atmos.ethz.ch::cmip6-ng cmip6-ng
