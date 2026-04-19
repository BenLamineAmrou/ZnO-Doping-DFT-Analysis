#!/bin/bash

# Define paths relative to the scripts folder
INPUT_FILE="../00-Gas-Reference/nh3_vacuum.out"
OUTPUT_FILE="../00-Gas-Reference/GAS_REFERENCE_DATA.txt"

echo "=== AMMONIA (NH3) VACUUM REFERENCE DATA ===" > $OUTPUT_FILE
echo "Project: ZnO Gas Sensor IIA3 - Phase 0" >> $OUTPUT_FILE
echo "Date: $(date)" >> $OUTPUT_FILE
echo "------------------------------------------" >> $OUTPUT_FILE

# Extract Final Total Energy
if [ -f "$INPUT_FILE" ]; then
    # Grab the very last 'total energy' line (final iteration)
    ENERGY=$(grep "!" $INPUT_FILE | tail -n 1 | awk '{print $5}')
    echo "Total Energy (E_gas): $ENERGY Ry" >> $OUTPUT_FILE
    
    echo "" >> $OUTPUT_FILE
    echo "Final Optimized Atomic Positions (Angstrom):" >> $OUTPUT_FILE
    # Extract the last position block
    grep -A 4 "ATOMIC_POSITIONS (angstrom)" $INPUT_FILE | tail -n 5 >> $OUTPUT_FILE
    
    echo "------------------------------------------" >> $OUTPUT_FILE
    echo "Status: SUCCESS - Ready for Adsorption Phase" >> $OUTPUT_FILE
else
    echo "Error: nh3_vacuum.out not found in 00-Gas-Reference!" >> $OUTPUT_FILE
fi

# Print it to the screen so you can see it immediately
cat $OUTPUT_FILE
