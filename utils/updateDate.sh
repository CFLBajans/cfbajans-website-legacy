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
# This script is used to update the meeting time date on the
# site.
# Guidance from: 
# http://thelinuxtips.com/2012/12/06/finding-the-nth-particular-week-in-a-month-shell-script/

clear
echo "Script to update meeting date. Assumes the meeting is\
 every 3rd Saturday of the month"

# constants
DAY="1"
FREQ="3"
WEBSITE="$PWD/../public_html"
# ------------------------------------------------------------
# functions
USAGE()
{
	echo "------------------------------------------------------"
	echo "USAGE :: updateDate YEAR MONTH"
	echo "For example: "
	echo "updateDate 2017 4"
	echo "The above will return the date of the 3rd Saturday in April\
 and update all html pages accordingly"
	echo "Valid values for YEAR ( 2016 to 2050 )"
    echo "Valid values for MONTH ( 1 to 12 )"
}


YearCheck()
{
    echo "$1" | grep -v "^[0-9]*$" >/dev/null 2>&1 && echo "Please enter the year" && USAGE
    if [[ ! "${1}" -le "2051" || "${1}" -eq "2016" ]]; then
        echo "Enter the correct Year [2017-2050]"
        USAGE
    fi    
}

MonthCheck()
{
    echo "$1" | grep -v "^[0-9]*$" >/dev/null 2>&1 && echo "Please enter the month" && USAGE
    if [[ ! "${1}" -le "12" || "${1}" -eq "0" ]]; then
        echo "Enter the correct Month [1-12]"
        USAGE
    fi
}

LastDigit()
{
	lastD="${1: -1}"
	
	if [[ $lastD == "1" ]]; then
        ordinalEnding="st"
    elif [[ $lastD == "2" ]]; then
    	ordinalEnding="nd"
    elif [[ $lastD == "3" ]]; then
    	ordinalEnding="rd"
    else
    	ordinalEnding="th"
    fi

    echo "$1$ordinalEnding"
}

MonthStr()
{
	if [[ $1 == "1" ]]; then
		mthStr="January"
	fi
	if [[ $1 == "2" ]]; then
		mthStr="February"
	fi
	if [[ $1 == "3" ]]; then
		mthStr="March"
	fi
	if [[ $1 == "4" ]]; then
		mthStr="April"
	fi
	if [[ $1 == "5" ]]; then
		mthStr="May"
	fi
	if [[ $1 == "6" ]]; then
		mthStr="June"
	fi
	if [[ $1 == "7" ]]; then
		mthStr="July"
	fi
	if [[ $1 == "8" ]]; then
		mthStr="August"
	fi
	if [[ $1 == "9" ]]; then
		mthStr="September"
	fi
	if [[ $1 == "10" ]]; then
		mthStr="October"
	fi
	if [[ $1 == "11" ]]; then
		mthStr="November"
	fi
	if [[ $1 == "12" ]]; then
		mthStr="December"
	fi
	echo "$mthStr"
}
# ------------------- end functions --------------------------

if [ "$#" -ne "2" ]; then
    USAGE
else
    YearCheck $1
    MonthCheck $2
    NY=$1
    NM=$2
    newDay=`cal $2 $1| tail +5|cut -c19,20| sed -n 1p`
    newMthStr=$(MonthStr ${NM})
    newDate="$newMthStr $(LastDigit ${newDay}), $NY"
     
    # get old date
    oldMth=$((NM-1))
	oldYr=$1

	if [[ $oldMth == "0" ]]; then
		oldYr=$((NY-1))
		oldMth="12"
	fi

	oldDay=`cal $oldMth $oldYr| tail +5|cut -c19,20| sed -n 1p`
	oldMthStr=$(MonthStr ${oldMth})
	oldDate="$oldMthStr $(LastDigit ${oldDay}), $oldYr"

	# change all the dates
	$PWD/updatePages.sh $WEBSITE "${oldDate}" "${newDate}"

echo "New Date: $newDate Old Date: $oldDate"
fi
