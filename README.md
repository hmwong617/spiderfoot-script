# Googler

Use googler to get the URL by company name

> Usage: run_google.sh [customer list file] [output file] [speed:default 30s]


```
./run_googler.sh url.txt output.txt 30
```

# Sipder script


## Procedures to run spiderfoot basic

```
cat XXXXX.csv | while read p;do url=`echo $p | cut -d "," -f 3`; sudo ./run_spider.sh $url ;done
```


## Procedures to run spiderfoot for BGP

```
cat XXXXX.csv | while read p;do url=`echo $p | cut -d "," -f 3`; sudo ./run_spider_bgp.sh $url ;done
```

## Procedures to merge basic output and bgp output

```
for i in `ls ../output/ | grep -v broken`;do python3 merge_spider_json.py $i ;done
```

# Reference
## Format of URL csv
```
English Name, Chinese Name, URL,
Chinese University of Hong Kong,ABC,www.cuhk.edu.hk,
Education Bureau,ABC,www.edb.gov.hk,
```

## Useful spiderfoot module
> sfp_dnsneighbor
> sfp_iknowwhatyoudownload
> sfp_viewdns
> sfp_whatcms
> sfp_shodan
> sfp_fullcontact
> sfp_hostio
> sfp_ipregistry
> sfp_spyse
> sfp_tool_cmseek
> sfp_tool_whatweb
