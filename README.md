# Digital Glitch Filter in Verilog

## Overview

This project implements a digital glitch filter using synthesizable
Verilog RTL.

The purpose of the glitch filter is to remove unwanted short pulses
or glitches from a digital sensor signal.

The filter accepts a change in the input signal only when the new
input value remains stable for at least two consecutive clock cycles.
Single-cycle glitches are ignored.

---

## Problem Statement

A temperature sensor provides a digital signal `sensor_in` to an FPGA.
Due to noise and line interference, the input may occasionally contain
spurious one-clock-cycle glitches.

The objective is to design a glitch filter that:

- Accepts a HIGH transition when `sensor_in` remains HIGH for at least
  two consecutive clock cycles.
- Accepts a LOW transition when `sensor_in` remains LOW for at least
  two consecutive clock cycles.
- Ignores single-cycle HIGH glitches.
- Ignores single-cycle LOW glitches.
- Operates using a 100 MHz system clock.
- Uses an active-low reset.

---

## Design Specifications

| Parameter | Specification |
|-----------|---------------|
| Design | Digital Glitch Filter |
| HDL | Verilog |
| Clock Frequency | 100 MHz |
| Clock Period | 10 ns |
| Reset | Active-low |
| Required Stability | 2 consecutive clock cycles |

---

## Module Interface

### Inputs

| Signal | Direction | Description |
|--------|-----------|-------------|
| `clk` | Input | 100 MHz system clock |
| `reset_n` | Input | Active-low reset |
| `sensor_in` | Input | Digital sensor input |

### Output

| Signal | Direction | Description |
|--------|-----------|-------------|
| `sensor_out` | Output | Filtered sensor output |

---

## Working Principle

The design stores the sensor input from the previous clock cycle in
a register called `previous_sensor`.

At every rising edge of the clock, the current `sensor_in` value is
compared with the previous sensor value.

### Case 1: Input changes

If:

```text
sensor_in != previous_sensor
