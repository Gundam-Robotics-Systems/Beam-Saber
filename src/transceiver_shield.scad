// =========================================================================
// GUNDAM ROBOTICS SYSTEMS - BEAM-SABER INTERNAL SHIELD CASING
// MU-METAL ELECTROMAGNETIC FARADAY ISOLATION FOR TRANSCEIVER NODE
// =========================================================================

// Aligned with the internal dimensions of our permanent rubber liner sleeve
RUBBER_INNER_DIAM = 21.7; // Inner clear bore diameter from previous chassis models
SHIELD_LENGTH     = 55.0; // Spans the full length of the transceiver PCB node
WALL_THICKNESS    = 1.5;  // 1.5mm Mu-Metal sheet rating for high flux absorption

// Derived Dimensions
SHIELD_OUTER_DIAM = RUBBER_INNER_DIAM - 0.1; // Smooth slide tolerance inside rubber liner
SHIELD_INNER_DIAM = SHIELD_OUTER_DIAM - (2 * WALL_THICKNESS);

$fn = 128; // High-definition arc resolution

module magnetic_shield_sleeve() {
    color("DarkGray", 1.0)
    difference() {
        // Main high-permeability nickel-iron magnetic redirection core
        cylinder(h = SHIELD_LENGTH, d = SHIELD_OUTER_DIAM, center = false);
        
        // Internal hollow bore to receive the transceiver board assembly
        translate([0, 0, -1])
            cylinder(h = SHIELD_LENGTH + 2, d = SHIELD_INNER_DIAM, center = false);
            
        // Longitudinal Wire Routing Slot (For 0.0V-1.0V Hexadecimal Control Bus Entry)
        // A 3.5mm cut allowing gold trace wire harnesses to pass into the enclave safely
        translate([0, -1.75, -1])
            cube([SHIELD_OUTER_DIAM, 3.5, SHIELD_LENGTH + 2], center = false);
            
        // Interlocking Alignment Tab Grooves (Prevents internal twisting during high-G maneuvers)
        for(z = [5, SHIELD_LENGTH - 10]) {
            translate([0, 0, z])
                rotate([90, 0, 0])
                    cylinder(h = SHIELD_OUTER_DIAM, d = 2.0, center = true);
        }
    }
}

module conductive_copper_inner_lining() {
    // Sputtered internal copper flash layer (0.05mm) to absorb high-frequency electric fields
    color("Copper", 0.6)
    difference() {
        cylinder(h = SHIELD_LENGTH - 2, d = SHIELD_INNER_DIAM - 0.02, center = false);
        translate([0, 0, -2])
            cylinder(h = SHIELD_LENGTH + 2, d = SHIELD_INNER_DIAM - 0.12, center = false);
        // Match the wire routing slot profile
        translate([0, -1.75, -2])
            cube([SHIELD_OUTER_DIAM, 3.5, SHIELD_LENGTH + 4], center = false);
    }
}

// Composite Layered Shield Construction Rendering
module complete_shield_assembly() {
    magnetic_shield_sleeve();
    translate([0, 0, 1]) // Center vertically
        conductive_copper_inner_lining();
}

complete_shield_assembly();
