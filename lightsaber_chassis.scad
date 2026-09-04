// =========================================================================
// HIERARCHICAL RECTILINEAR OPEN-AIR RESONATOR CHASSIS DEFINITION
// DESIGN STANDARD: NATIVE HEXADECIMAL HARMONIC STABILIZATION (RT-SPEC)
// =========================================================================

// TARGET MODEL SELECTION: 1 = Ruby Red (0x01), 5 = Emerald Green (0x05), 8 = Cobalt Blue (0x08)
MODEL_SELECT = 5; 

// AUTOMATED HARMONIC MECHANICAL DIMENSION SCALE
function get_hilt_length(m) = (m == 1) ? 203.2  : ((m == 5) ? 254.0  : 266.7);  // 8", 10", or 10.5" in mm
function get_wall_thick(m)  = (m == 1) ? 4.5    : ((m == 5) ? 6.0    : 7.5);    // Thicker for higher energy
function get_crystal_rad(m)  = (m == 1) ? 8.2    : ((m == 5) ? 10.5   : 12.1);   // Resonant capsule volume

HILT_LENGTH  = get_hilt_length(MODEL_SELECT);
WALL_THICK   = get_wall_thick(MODEL_SELECT);
CRYSTAL_RAD  = get_crystal_rad(MODEL_SELECT);
OUTER_DIAM   = 38.1; // Standard 1.5 inch ergonomic grip
INNER_DIAM   = OUTER_DIAM - (2 * WALL_THICK);

$fn = 128; // Enforce high-precision circular rendering

module main_assembly() {
    difference() {
        // Core Titanium Structural Hull
        cylinder(h = HILT_LENGTH, d = OUTER_DIAM, center = false);
        
        // Internal Architecture Main Bore
        translate([0, 0, -1])
            cylinder(h = HILT_LENGTH + 2, d = INNER_DIAM, center = false);
            
        // Laser-Etched Microfluidic Coolant Channels (Transpiration Ring)
        for(i = [0 : 45 : 360]) {
            rotate([0, 0, i])
            translate([(INNER_DIAM/2) + 1, 0, HILT_LENGTH - 40])
                cylinder(h = 42, d = 1.2, center = false);
        }
    }
    
    // Internal Shock-Absorbing Crystal Chamber Retainer
    translate([0, 0, HILT_LENGTH * 0.35]) {
        difference() {
            // Rigid Mount Bracket
            cylinder(h = 30, d = INNER_DIAM - 0.1, center = true);
            // Floating Resonant Crystal Capsule Enclosure
            cylinder(h = 32, r = CRYSTAL_RAD, center = true);
        }
    }
}

// Render the specified hardware profile
main_assembly();
