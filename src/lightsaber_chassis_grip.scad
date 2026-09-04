// =========================================================================
// GUNDAM ROBOTICS SYSTEMS - BEAM-SABER CHASSIS COMPILATION
// INTEGRATES PERMANENT VULCANIZED RUBBER THERMAL-SHOCK LINER
// DESIGN STANDARD: NATIVE HEXADECIMAL HARMONIC STABILIZATION (RT-SPEC)
// =========================================================================

// TARGET MODEL SELECTION: 1 = Ruby Red (0x01), 5 = Emerald Green (0x05), 8 = Cobalt Blue (0x08)
MODEL_SELECT = 5; 

// AUTOMATED HARMONIC MECHANICAL DIMENSION SCALE
function get_hilt_length(m) = (m == 1) ? 203.2  : ((m == 5) ? 254.0  : 266.7);  // mm
function get_wall_thick(m)  = (m == 1) ? 4.5    : ((m == 5) ? 6.0    : 7.5);    // Titanium shell thickness
function get_rubber_thick(m) = (m == 1) ? 1.5    : ((m == 5) ? 2.2    : 3.0);    // Scaled dampening thickness

HILT_LENGTH  = get_hilt_length(MODEL_SELECT);
WALL_THICK   = get_wall_thick(MODEL_SELECT);
RUBBER_THICK = get_rubber_thick(MODEL_SELECT);
OUTER_DIAM   = 38.1; // Standard 1.5 inch ergonomic grip

// Derived Diameters for Perfect Concentric Nesting
TITANIUM_INNER_DIAM = OUTER_DIAM - (2 * WALL_THICK);
RUBBER_INNER_DIAM   = TITANIUM_INNER_DIAM - (2 * RUBBER_THICK);

$fn = 128;

module titanium_outer_hull() {
    color("LightGray", 0.9)
    difference() {
        // Core Titanium Structural Hull
        cylinder(h = HILT_LENGTH, d = OUTER_DIAM, center = false);
        // Internal Cavity to receive Rubber Protection Liner
        translate([0, 0, -1])
            cylinder(h = HILT_LENGTH + 2, d = TITANIUM_INNER_DIAM, center = false);
    }
}

module permanent_rubber_liner() {
    // Vulcanized Fluoroelastomer Shock & Heat Shield
    color("Charcoal", 1.0) 
    translate([0, 0, 2]) // Recessed slightly from bottom endcap
    difference() {
        // Outer boundary matches the interior of the titanium shell perfectly
        cylinder(h = HILT_LENGTH - 4, d = TITANIUM_INNER_DIAM - 0.05, center = false);
        // Core internal bore for computing arrays and magnetic coils
        translate([0, 0, -1])
            cylinder(h = HILT_LENGTH, d = RUBBER_INNER_DIAM, center = false);
    }
}

module microfluidic_channels() {
    // Transpiration laser cuts for coolant distribution
    color("Cyan", 0.5)
    for(i = [0 : 45 : 360]) {
        rotate([0, 0, i])
        translate([(RUBBER_INNER_DIAM/2) + 0.5, 0, HILT_LENGTH - 40])
            cylinder(h = 42, d = 1.2, center = false);
    }
}

// Complete Concentric Assembly Render
module complete_assembly() {
    titanium_outer_hull();
    permanent_rubber_liner();
    microfluidic_channels();
}

complete_assembly();
