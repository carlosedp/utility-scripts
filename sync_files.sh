#!/bin/bash
#
#
# Usage: ./sync_files.sh -o [origin_dir] -d [destination_dir] [params]
#
# Params:
#       --origin | -o         |  Origin dir
#       --dest | -d           |  Destination dir
#       --dry                 |  Dry run, do not perform sync
#       --del                 |  Delete destination if not present on origin
#       --backup              |  Backup deleted/overwritten files into [dest]/Backup
#       --excludes-file=file  |  Excludes files/dirs listed on file (one match per line)
#

# Directory origin is the default script dir
ORIGINPATH=`pwd`

# Default destination drive
DEST=""

# RSYNC_PARAM="-avuP"
RSYNC_PARAM="-rlptgoDvuP"
RSYNC_DEL="--delete --delete-excluded"
CHECK_PARAM="--modify-window=2"     #Windows Friendly way to check file modification

RSYNC_EXCLUDE=""
#EXCLUDE_FILE="${MY_DIR}/cygwin_excludes"
#RSYNC_EXCLUDE="--exclude-from=${EXCLUDE_FILE}"
#RSYNC_EXCLUDE="--exclude */psptoolchain/*"

#Parse command line arguments
for i in $*
do
	case $i in
    --origin=*)
        ORIGINPATH=`echo $i | sed 's/[-a-zA-Z0-9]*=//' | sed 's/\/$//'`
        continue
        ;;
    -o)
        ORIGINPATH=`echo $2 | sed 's/\/$//'`
        shift 2
        continue
        ;;
    --dest=*)
        DEST=`echo $i | sed 's/[-a-zA-Z0-9]*=//' | sed 's/\/$//'`
        ;;
    -d)
        DEST=`echo $2 | sed 's/\/$//'`
        shift 2
        continue
        ;;
    --dry)
        RSYNC_PARAM="${RSYNC_PARAM}n"
        continue
        ;;
    --del)
        RSYNC_PARAM="${RSYNC_PARAM} ${RSYNC_DEL}"
        continue
        ;;
    --backup)
        RSYNC_PARAM="${RSYNC_PARAM} --backup --backup-dir=${DEST}/Backup"
        continue
        ;;
    --excludes-file=*)
        EXCLUDE_FILE=`echo $i | sed 's/[-a-zA-Z0-9]*=//' | sed 's/\/$//'`
        RSYNC_EXCLUDE="--exclude-from=${EXCLUDE_FILE}"
        ;;
    -*)
        echo "Unknown parameter '$i'"
        exit 1
		;;
 	esac
done

# Check if origin dir exists
if [ ! -d ${ORIGINPATH} ]; then
echo "Error: '${ORIGINPATH}' origin does not exist!!"
echo "EXITING"
exit 1
fi

# Check if destination dir exists
if [ ! -d ${DEST} ]; then
echo "Error: '${DEST}' destination does not exist!!"
echo "EXITING"
exit 1
fi

if [ ${ORIGINPATH} == "." ]; then
ORIGINPATH=`pwd`
fi

ORIGINNAME=`basename ${ORIGINPATH}`

echo "Origin Path:" ${ORIGINPATH}
echo "Origin Name:" ${ORIGINNAME}

EXEC_COMMAND="rsync ${RSYNC_PARAM} ${CHECK_PARAM} ${RSYNC_EXCLUDE} ${ORIGINPATH}/ ${DEST}/${ORIGINNAME}/"
${EXEC_COMMAND}
