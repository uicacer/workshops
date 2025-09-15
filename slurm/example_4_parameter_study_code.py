#!/usr/bin/env python3
import argparse
import random
import time

parser = argparse.ArgumentParser()
parser.add_argument('--param', type=float, required=True)
parser.add_argument('--output', type=str, required=True)
args = parser.parse_args()

# Simple simulation: random walk with parameter as step size
result = sum(random.uniform(-args.param, args.param) for _ in range(1000))

# Save result
with open(args.output, 'w') as f:
    f.write(f"Parameter: {args.param}\nResult: {result:.6f}\n")

print(f"Simulation done! Parameter: {args.param}, Result: {result:.6f}")
