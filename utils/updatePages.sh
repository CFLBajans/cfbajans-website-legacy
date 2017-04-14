#!/bin/bash
# ------------------------------------------------------------
# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.
# ------------------------------------------------------------
# This script is used to change the meeting time date on the
# site

clear
echo "Script to update meeting date."
echo $1 $2 $3

if [ "$#" -ne "3" ]; then
    echo "USAGE :: updatePages path-to-pages oldDate newDate"
	echo "Dates should be in the format - Month DDth, YYYY"
	echo "For example: "
	echo "updateDate /home/public_html 'March 18th, 2017' 'April 22nd, 2017'"
	echo "The above will return update the date on all html pages accordingly."
	echo "Please rerun script with correct arguments."
	exit 0
else
	noFiles=`grep -rl "$2" $1`

	if [[ -z $noFiles ]]; then
		echo "No files with the date $2 were found. Exiting!"
		exit 1
	else
		grep -rl "$2" $1 | xargs sed -i '' -e "s/${2}/${3}/g"
		echo "Date changes complete!"
	fi
fi