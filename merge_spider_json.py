import json
import sys
import os

path_to_file="spiderfoot-3.3/output/"
path_to_file_bgp="spiderfoot-3.3/output.bgp/"
path_to_file_new="spiderfoot-3.3/output.new2/"


if (os.stat("../output/"+ str(sys.argv[1])).st_size == 0):
    print("[DEBUG] Emtpy data file")
    quit()

if (os.stat("../output.bgp/"+ str(sys.argv[1])).st_size == 0):
    print("[DEBUG] Emtpy bgpfile")
    quit()

print("[DEBUG] Processing" + str(sys.argv[1]))

with open("../output/"+ str(sys.argv[1])) as f:
        data = json.load(f)

#print("original data")
#print(json.dumps(data, indent=4))
with open("../output.bgp/"+ str(sys.argv[1])) as bgp:
        bgp_data = json.load(bgp)

#print("bgp data")
#print(json.dumps(bgp_data, indent=4))

found_bgp=False

#for spi in data:
#    if (spi["type"] == "BGP AS Membership"):
#        print("find BGP")
#        found_bgp=True
#        break

#if not bool(found_bgp):
#    print("not found bgp, insert data")
for obj in bgp_data:
#        if ((obj["type"] == "BGP AS Membership") or (obj["type"] == "Netblock Membership") or (obj["type"] == "Physical Address")):
#        if (obj["type"] == "BGP AS Membership"):
    data.append(obj)

#print(json.dumps(data, indent=4))

with open("../output.new/"+ str(sys.argv[1]),'w') as newf:
    json.dump(data,newf,indent=4)
