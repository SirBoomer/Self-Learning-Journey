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

Self-directed RTL and verification practice using Questa.
Every design has a testbench; the later ones are self-checking with
independent reference models.


### UART Transmitter

A serial transmitter that sends one byte at a time in standard 8-N-1 format.
Written in Verilog, simulated and verified in Questa.

**Frame format**

```
idle (1) | start (0) | d0 d1 d2 d3 d4 d5 d6 d7 | stop (1) | idle (1)
```

- 8 data bits, least significant bit first
- Each bit is held for `CLKS_PER_BIT` clock cycles
- No clock is sent on the wire; the receiver times each bit from the
  falling edge of the start bit, using an agreed baud rate

**Design** (`uart_tx.v`)

A four-state FSM (IDLE, START, DATA, STOP) driving a small datapath:

- a counter that measures one bit period
- a bit index that tracks which of the 8 data bits is being sent
- a shift register that presents the next bit on `tx`

`CLKS_PER_BIT` is a parameter, so the same module works at any baud rate
(434 for 115200 baud from a 50 MHz clock; 4 in simulation to keep tests fast).
A `busy` output indicates a frame is in progress, and `start` is ignored
while busy so a transmission in flight cannot be corrupted.

**Verification** (`uart_tx_tb.v`)

The testbench contains a serial receiver written as a Verilog task. It waits
for the start bit, then samples in the middle of each bit period and
reassembles the byte — an independent decoder, so the check does not depend
on anything inside the design.

- **Exhaustive test:** all 256 byte values are transmitted and decoded, and
  each is compared against what was sent.
- **Edge case:** `start` is asserted mid-frame while `busy` is high, and the
  test confirms the frame in flight is unaffected.

The testbench was validated by deliberately introducing bugs into the design
and confirming they were caught. An off-by-one in the bit counter, for
example, produced exactly 128 failures — the bytes whose top bit differed
from the stop bit — which matched the predicted count.

**Running it**

```
vlib work
vlog uart_tx.v uart_tx_tb.v
vsim -c uart_tx_tb -do "run -all; quit"
```

Expected output: `PASS: all 256 byte values transmitted correctly`

### Exercises

Smaller designs written while working through Verilog fundamentals.
Each has a testbench; the later ones are self-checking with independent
reference models, and were validated by deliberately introducing a bug
and confirming it was caught.

| Files | Concepts |
|---|---|
| `and_gate.v`, `and_gate_tb.v`, `and_gate_tb2.v` | continuous assignment, first self-checking testbench |
| `adder4.v`, `adder4_tb.v` | multi-bit buses, exhaustive test over all 256 input pairs, reference model |
| `clock_test.v` | clock generation, `$monitor`, simulation time |
| `dff.v`, `dff_rst.v` | flip-flops, synchronous vs asynchronous reset |
| `shift2.v` | blocking vs non-blocking assignment |
| `counter4.v`, `counter.v` | sequential logic with enable; parameterised width, tested at 4 and 8 bits |
| `mux4.v` | combinational `always @(*)`, `case`, avoiding inferred latches |
| `traffic.v` | three-block FSM style, Moore outputs |
| `seq_detect.v`, `seq_detect_mealy.v` | overlapping sequence detection (`1011`), Moore vs Mealy |