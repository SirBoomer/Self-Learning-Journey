import sys
import re
if len(sys.argv) < 3:
    print("Usage: python logreport.py <logfile> <reportfile>")
    sys.exit(1)
log=sys.argv[1]
report=sys.argv[2]
class LogError:
    def __init__(self, time, code):
        self.time=time
        self.code=code
    def __repr__(self):
        return f"LogError:({self.time}, {self.code})"
    
errors=[]
counts={}
with open (log) as f:
    for line in f:
        match = re.search(r"(\d+)ns ERROR: \[(\w+)\]", line)

        if match:
            e=LogError(int(match.group(1)),match.group(2))
            errors.append(e)

for e in errors:
    if e.code not in counts:
        counts[e.code] = 1
    else:
        counts[e.code]+=1
ranked= sorted(counts.items(), key=lambda pair:pair[1], reverse=True)
first= min(errors, key=lambda e:e.time)
last= max(errors, key=lambda e:e.time)


with open(report, "w") as f:
    f.write(f"Log summary for {log}\n")
    f.write(f"Total errors : {len(errors)}\n")
    f.write("\n")
    for code, count in ranked:
        f.write(f"{code} {count}\n")
    f.write(f"\n")
    f.write(f"First error at {first.time}ns\n")
    f.write(f"Last error at {last.time}ns\n")
    






