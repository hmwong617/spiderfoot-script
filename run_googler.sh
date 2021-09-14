#!/bin/bash

### Usage: run_google.sh [customer list file] [output file] [speed:default 30s]
### By Alex Wong 2021
###

source_file=$1
output_file=$2
speed=$3

echo "[DEBUG] Input file: $source_file"
echo "[DEBUG] Output file: $output_file"

if [ -z $speed ]
then
    speed=30
fi
echo "[DEBUG] Speed: $speed"

line=`wc -l $source_file | cut -d " " -f1`
count=0
echo "[DEBUG] Total: $line"

func_googler(){
    ans=`googler -x -n 1 --np "$1" | grep http -m 1 | cut -d '/' -f 3`; 
    echo "$ans"
}

func_check_common_url(){

        if [[ $1 == *"facebook.com"* ]]; then
            retry=true;
        elif [[ $1 == *"hkgbusiness.com"* ]]; then
            retry=true;
        elif [[ $1 == *"bloomberg.com"* ]]; then
            retry=true;
        elif [[ $1 == *"wikipedia."* ]]; then
            retry=true;
        elif [[ $1 == *"hktdc.com"* ]]; then
            retry=true;
        elif [[ $1 == *"linkedin.com"* ]]; then
            retry=true;
        elif [[ $1 == *"webb-site.com"* ]]; then
            retry=true;
        elif [[ $1 == *"hongkong-corp.com"* ]]; then
            retry=true;
        elif [[ $1 == *"openrice.com"* ]]; then
            retry=true;
        elif [[ $1 == *"hkong.net"* ]];then
            retru=true;
        elif [[ $1 == *"cr.gov"* ]];then
            retru=true;
        elif [[ $1 == *"jobdailyhk.com"* ]];then
            retru=true;
        elif [[ $1 == *"twitter.com"* ]];then
            retru=true;
        else
            retry=false;
            echo "$1";
	fi
}

cat $1 | while read p2;
    do 
        p1=`echo $p2 | cut -d "," -f1`; 
        ans=`echo $p2 | cut -d "," -f3`;
	ans=$(func_check_common_url $ans);
        if [ -z $ans ];then
            e_name="${p1/Ltd/\"\"}";
	    echo "[DEBUG] $p1 $e_name";
            e_name="${e_name/Limited/\"\"}";
            e_name="${e_name/Company/\"\"}";
            echo "[DEBUG] Googler $e_name"
	    ans=$(func_googler "${e_name}");
            echo "[DEBUG] Result: $ans";
        fi

	ans=$(func_check_common_url $ans);
        if [ -z $ans ];then
	    ans=$(func_googler "${e_name} home");
            echo "[DEBUG] Result: $ans";
        fi
       	
	ans=$(func_check_common_url $ans);

        if [ -z $output_file ]
	then
            echo "$p1,,$ans,"
        else
            echo "$p1,,$ans," >> $output_file
	fi
        count=$(($count+1))
        echo "[DEBUG] Googler $p1 ... [DONE] $count/$line"
        sleep $[ ( $RANDOM % $speed )  + 10 ]s; 
    done

#cat SuccessfulApplicantListMorethan50.csv | while read p1; do p=`echo $p1 | tr -d '\r\n'`;  cname=`echo $p | cut -d "," -f 1`; url=`echo $p | cut -d "," -f 3`; if [ -z "$url" ]; then ans=`googler -n 1 --np $cname | grep http | cut -d '/' -f 3`; echo "$p$ans,";sleep $[ ( $RANDOM % 30 )  + 10 ]s; fi;done
            ans="";
