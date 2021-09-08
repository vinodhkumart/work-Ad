#!/bin/bash

# Script to generate random numbers from 1 to 10 range

for i in {1..10}
do
	echo $i
done |
shuf | tr '\n' ' '
