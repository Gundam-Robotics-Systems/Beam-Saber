// =========================================================================
// GUNDAM ROBOTICS SYSTEMS - BEAM-SABER SPINNING GOLD CORE ASSEMBLY
// INTEGRATES MAXWELL HELICAL ROTATION SYMMETRY & DAMPENING
// =========================================================================

MODEL_SELECT = 5; 

function get_hilt_length(m) = (m == 1) ? 203.2  : ((m == 5) ? 254.0  : 266.7);  
function get_wall_thick(m)  = (m == 1) ? 4.5    : ((m == 5) ? 6.0    : 7.5);    

HILT_LENGTH  = get_hilt_length(MODEL_SELECT);
WALL_THICK   = get_wall_thick(MODEL_SELECT);
OUTER_DIAM   = 38.1; 

TITANIUM_INNER_DIAM = OUTER_DIAM - (2 * WALL_THICK);
ROTATION_CLEARANCE  = 1.5; // Mechanical air gap for spinning core
GOLD_CORE_DIAM      = TITANIUM_INNER_DIAM - (2 * ROTATION_CLEARANCE);

$fn = 128;

module titanium_housing() {
    color("LightGray", 0.5)
    difference() {
        cylinder(h = HILT_LENGTH, d = OUTER_DIAM);
        // Clear interior for the spinning sub-assembly
        translate([0, 0, -1])
            cylinder(h = HILT_LENGTH + 2, d = TITANIUM_INNER_DIAM);
    }
}

module spinning_gold_lattice_core() {
    // Physically spinning inner actuator core utilizing pure 24K Gold
    color("Gold", 1.0)
    translate([0, 0, 10]) { // Recessed for bearing mounts
        difference() {
            cylinder(h = HILT_LENGTH - 20, d = GOLD_CORE_DIAM);
            // Core internal channel for the optoelectronic photonic line
            translate([0, 0, -1])
                cylinder(h = HILT_LENGTH, d = GOLD_CORE_DIAM * 0.4);
        }
    }
}

module bearing_race_mounts() {
    // Upper and lower industrial ceramic bearings for high-RPM vibration damping
    color("DarkKaki", 0.8) {
        translate([0, 0, 5])
            difference() { cylinder(h = 5, d = TITANIUM_INNER_DIAM); cylinder(h = 6, d = GOLD_CORE_DIAM); }
        translate([0, 0, HILT_LENGTH - 10])
            difference() { cylinder(h = 5, d = TITANIUM_INNER_DIAM); cylinder(h = 6, d = GOLD_CORE_DIAM); }
    }
}

// Render the spinning electromagnetic engine layout
titanium_housing();
bearing_race_mounts();
spinning_gold_lattice_core();
