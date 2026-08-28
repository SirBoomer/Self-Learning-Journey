import re
class LogError:
    def __init__(self, time, code):
        self.time = time
        self.code = code
    def __repr__(self):
        return f"LogError({self.time}, {self.code})"
errors=[]
with open("sim.log") as f:

    for line in f:
        match = re.search(r"(\d+)ns ERROR: \[(\w+)\]", line)

        if match:
            e=LogError(int(match.group(1)), match.group(2))
            errors.append(e)

errors = sorted(errors, key=lambda e: e.time, reverse=True)
print(errors)