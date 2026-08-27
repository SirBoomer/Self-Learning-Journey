import re
with open("sim.log") as f:
    
    count={}
    for line in f:
        match = re.search(r"(\d+)ns ERROR: \[(\w+)\]", line)
        if match:
        
            
            if match.group(2) not in count:
                count[match.group(2)]=1
            else:
                count[match.group(2)]+=1
print(count)