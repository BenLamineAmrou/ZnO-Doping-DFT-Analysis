#!/bin/bash

# Move to the root directory automatically
cd "$(dirname "$0")/.."

MASTER="PROJECT_SUMMARY.txt"

# Create the Master Header
echo "==========================================================" > $MASTER
echo "   ZnO GAS SENSOR SIMULATION - MASTER SUMMARY" >> $MASTER
echo "   Students: Amrou Mustapha Ben Lamine | Nour ElHouda Latrech | Group: B02 G12 IIA3" >> $MASTER
echo "   Date: $(date)" >> $MASTER
echo "==========================================================" >> $MASTER
echo "" >> $MASTER

# --- PHASE 1: PRIMITIVE CELL ---
P1_DIR="01-Primitive-Cell"
P1_REP="$P1_DIR/PHASE1_REPORT.txt"

echo "PHASE 1: PRIMITIVE CELL CALIBRATION" > $P1_REP
echo "-----------------------------------" >> $P1_REP
if [ -f "$P1_DIR/zno_prim.out" ]; then
    E1=$(grep "!" $P1_DIR/zno_prim.out | tail -1 | awk '{print $5}')
    ALAT=$(grep "lattice parameter (alat)" $P1_DIR/zno_prim.out | tail -1 | awk '{print $5}')
    ALAT_ANG=$(echo "$ALAT * 0.529177" | bc -l | cut -c 1-6)
    echo "Lattice Constant (a): $ALAT_ANG Angstrom" >> $P1_REP
    echo "Total Energy (4 atoms): $E1 Ry" >> $P1_REP
fi
if [ -f "$P1_DIR/zno_prim.dos" ]; then
    EF1=$(grep "EFermi =" $P1_DIR/zno_prim.dos | cut -d "=" -f 2 | awk '{print $1}')
    echo "Fermi Energy (E_f): $EF1 eV" >> $P1_REP
fi
cat $P1_REP >> $MASTER
echo "" >> $MASTER


# --- PHASE 2: PURE SUPERCELL ---
P2_DIR="02-Pure-Supercell"
P2_REP="$P2_DIR/PHASE2_REPORT.txt"

echo "PHASE 2: 32-ATOM PURE SUPERCELL BASELINE" > $P2_REP
echo "----------------------------------------" >> $P2_REP
if [ -f "$P2_DIR/zno_super.out" ]; then
    E2=$(grep "!" $P2_DIR/zno_super.out | tail -1 | awk '{print $5}')
    E2_SCALED=$(echo "scale=6; $E2 / 8" | bc -l)
    echo "Total Energy (32 atoms): $E2 Ry" >> $P2_REP
    echo "Scaled Energy (per unit): $E2_SCALED Ry" >> $P2_REP
    
    # Validation Check against Phase 1
    if [ -n "$E1" ]; then
        STABILITY=$(echo "scale=5; $E2_SCALED - ($E1)" | bc -l | sed 's/-/ /')
        echo "Stability Deviation from Phase 1: $STABILITY Ry" >> $P2_REP
    fi
fi
if [ -f "$P2_DIR/zno_super.dos" ]; then
    EF2=$(grep "EFermi =" $P2_DIR/zno_super.dos | cut -d "=" -f 2 | awk '{print $1}')
    echo "Fermi Energy (E_f): $EF2 eV" >> $P2_REP
fi
cat $P2_REP >> $MASTER
echo "" >> $MASTER

