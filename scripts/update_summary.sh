#!/bin/bash
cd "$(dirname "$0")/.."
MASTER="PROJECT_SUMMARY.txt"

# --- Header ---
echo "==============================================================================" > $MASTER
echo "   MASTER SUMMARY - Student: Amrou Mustapha Ben Lamine - Nour Elhouda Latrech" >> $MASTER
echo "==============================================================================" >> $MASTER
echo "" >> $MASTER

# --- PHASE 1 (Primitive) ---
P1_DIR="01-Primitive-Cell"
P1_REP="$P1_DIR/PHASE1_REPORT.txt"
if [ -f "$P1_DIR/zno_prim.out" ]; then
    E1=$(grep "!" $P1_DIR/zno_prim.out | tail -1 | awk '{print $5}')
    echo "PHASE 1: PRIMITIVE CELL" > $P1_REP
    echo "Total Energy: $E1 Ry" >> $P1_REP
    if [ -f "$P1_DIR/zno_prim.dos" ]; then
        EF1=$(grep "EFermi =" $P1_DIR/zno_prim.dos | cut -d "=" -f 2 | awk '{print $1}')
        echo "Fermi Energy: $EF1 eV" >> $P1_REP
    fi
    cat $P1_REP >> $MASTER
    echo "" >> $MASTER
fi

# --- PHASE 2 (Pure Supercell) ---
P2_DIR="02-Pure-Supercell"
P2_REP="$P2_DIR/PHASE2_REPORT.txt"
if [ -f "$P2_DIR/zno_super.out" ]; then
    E2=$(grep "!" $P2_DIR/zno_super.out | tail -1 | awk '{print $5}')
    echo "PHASE 2: 32-ATOM PURE SUPERCELL" > $P2_REP
    echo "Total Energy: $E2 Ry" >> $P2_REP
    if [ -f "$P2_DIR/zno_super.dos" ]; then
        EF2=$(grep "EFermi =" $P2_DIR/zno_super.dos | cut -d "=" -f 2 | awk '{print $1}')
        echo "Fermi Energy: $EF2 eV" >> $P2_REP
    fi
    cat $P2_REP >> $MASTER
    echo "" >> $MASTER
fi

# --- PHASE 3 (Doped Supercell) ---
P3_DIR="03-Doped-Supercell"
P3_REP="$P3_DIR/PHASE3_REPORT.txt"
if [ -f "$P3_DIR/zno_doped.out" ]; then
    E3=$(grep "!" $P3_DIR/zno_doped.out | tail -1 | awk '{print $5}')
    echo "PHASE 3: CALCIUM DOPED SUPERCELL" > $P3_REP
    echo "Total Energy (Doped): $E3 Ry" >> $P3_REP
    
    if [ -f "$P3_DIR/zno_doped.dos" ]; then
        EF3=$(grep "EFermi =" $P3_DIR/zno_doped.dos | cut -d "=" -f 2 | awk '{print $1}')
        echo "Fermi Energy (Doped): $EF3 eV" >> $P3_REP
        
        # SENSOR LIAISON CALCULATION
        SHIFT=$(echo "scale=4; $EF3 - ($EF2)" | bc -l)
        echo "Fermi Shift (Delta Ef): $SHIFT eV" >> $P3_REP
    fi
    cat $P3_REP >> $MASTER
fi
