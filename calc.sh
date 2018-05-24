#!/bin/sh
printUsage () {
  printf "\n"
  printf "A utility to download and calculate and check the MD5Sum of a file.\n\n"
  printf "\n"
  printf "  * File is downloaded to a random file name.\n"
  printf "  * MD5 sum is calculated.\n"
  printf "  * If checksums match, will send a GET request to the SUCCESS_CALLBACK_URL\n"
  printf "  * If checksums do not match, will send GET to ERROR_CALLBACK_URL\n"
  printf "  * If KEEP_FILE arg is set, file will not be deleted from disk\n"
  printf "\n"
  printf "\n"
  printf "md5checker <SOURCE_FILE_URL> <MD5SUM> <SUCCESS_CALLBACK_URL> <ERROR_CALLBACK_URL> [KEEP_FILE]\n"
  printf "\n"
  printf "\n"
}

if [ "$#" -lt "4" ]; then
  printf "\n"
  printf "All arguments must be supplied ($# -> $*).\n"
  printf "\n"
  printUsage
  exit 0
fi

SFU=$1
MD5=$2
SUC=$3
ERR=$4

if [ -z "$5" ]; then
  KEEP=1
else
  KEEP=""
fi

DFN=/tmp/$(uuidgen)

wget -q -O ${DFN} ${SFU}
CSM=$(md5sum ${DFN} | cut -d' ' -f 1)
if [ "${CSM}" == "${MD5}" ]; then
  echo "MD5 $DFN sum SUCCESS"
  $(wget -q ${SUC} > /dev/null)
else
  echo "MD5 $DFN sum ERROR ($CSM not eq $MD5)"
  wget -q ${ERR}  > /dev/null
fi

if ! [ -z "${KEEP}" ]; then
  rm -f ${DFN}
fi
