#!/bin/bash


if [ -a ../output.bgp/$1.json ]; then
	echo "[DEBUG] file exist: ../output.bgp/$1.json"
	exit
fi


#sudo timeout 5m python3 ./sf.py -d -q -s $1 -m sfp_dnsraw,sfp_dnsresolve,sfp_jsonwhoiscom,sfp_crt,sfp_emailcrawlrsfp_emailcrawlr,sfp_snov,sfp_pgp,sfp_phishtank,sfp_emergingthreats,sfp_fringeproject,sfp_grep_app,sfp_hackertarget,sfp_hosting,sfp_alienvaultiprep,sfp_hunter,sfp_hybrid_analysis,sfp_numverify,sfp_opencorporates,sfp_openphish,sfp_robtex,sfp_skymem,sfp_sorbs,sfp_spamcop,sfp_spamhaus,sfp_sslcert,sfp_uceprotect,sfp_webframework,sfp_webserver -o json > ./output/$1.json

#sudo timeout 10m python3 ./sf.py -d -q -s $1 -m sfp_dnsraw,sfp_dnsresolve,sfp_bgpview,sfp_onioncity,sfp_onionsearchengine,sfp_dnsgrep,sfp_darksearch,sfp_digitaloceanspace,sfp_crt,sfp_arin -o json > ./output.bgp/$1.json
cd ../spiderfoot-3.3/

sudo python3 ./sf.py -d -q -s $1 -m sfp_dnsraw,sfp_dnsresolve,sfp_bgpview,sfp_onioncity,sfp_onionsearchengine,sfp_dnsgrep,sfp_darksearch,sfp_digitaloceanspace,sfp_crt,sfp_arin -o json > ../output.bgp/$1.json


if [ $? -eq 124 ]; then
	echo "[DEBUG] Timeout. Move output to broken."
	mv ../output.bgp/$1.json ../output.bgp/broken/$1.json
	touch ../output.bgp/$1.json
fi


