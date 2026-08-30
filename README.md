# Self-Learning Journey

A self-directed learning log towards design verification.

Python fundamentals ending with a log-parsing CLI tool, then Verilog and testbenches.

Tools: Visual Studio Code, Python, Questa Starter, Git.

## Python

`python/` holds the exercises I worked through to build `logreport.py`.

`logreport.py` parses a simulation log, counts errors by type, ranks them, and writes a summary file.

Run it with:

```
python logreport.py sim.log report.txt
```

Example output:

```
Log summary for sim.log
Total errors: 4

ASSERT_FAIL 2
X_PROP 1
CHECKSUM 1

First error at 4820ns
Last error at 10400ns
```

## Verilog

`verilog/` contains an AND gate module and a self-checking testbench.

I verified the testbench by deliberately breaking the design, confirming it caught the bug.
