import csv
import json

nodes = []
links = []

# Create beacons
with open('beacons.csv', mode='r') as csv_file:
    csv_reader = csv.DictReader(csv_file)

    for row in csv_reader:
        nodes.append(row)

# Add node Icon

for node in nodes:
    nodeIcon = u'\uf0e7'

    if node["pbid"] == "":
        nodeIcon = u'\uf0e7'

    else:
        nodeIcon = u'\uf0e7'
    
    node.update({"nodeIcon":nodeIcon})


# Create Links
for node in nodes:
    beacon_source = node["id"]
    beacon_target = ""
    beacon_type = ""
    

    if node["pbid"] == "":
        beacon_type = "HTTP"
        beacon_target = "0" # teamserver
    else:
        beacon_type = "SMB"
        beacon_target = node["pbid"]
        
    
    # Add each beacon to list
    links.append({"source":beacon_source,"target":beacon_target,"type":beacon_type})

# Create teamserver reference
nodes.append({
      "pid": "teamserver", 
      "host": "teamserver",
      "id": "0",
      "user": "teamserver",
      "pbid": "",
      "note": "",
      "charset": "",
      "internal": "",
      "ver": "",
      "last": "",
      "alive": "",
      "os": "Cobalt Strike",
      "session": "",
      "barch": "",
      "lastf": "",
      "external": "",
      "computer": "",
      "port": "",
      "is64": "",
      "nodeIcon":u'\uf233'
    })


print(nodes)
print(links)

output = json.dumps({"nodes":nodes,"links":links},ensure_ascii=False).encode('utf8')
#print(output)

with open('beacons.json', 'wb') as the_file:
    the_file.write(output)

