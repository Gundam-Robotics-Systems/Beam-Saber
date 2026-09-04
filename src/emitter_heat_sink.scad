// =========================================================================
// GUNDAM ROBOTICS SYSTEMS - BEAM-SABER EMITTER HEAT-SINK RING
// THERMAL MANAGEMENT COUPLING FOR ACTIVE MICROFLUIDIC RECIRCULATION
// =========================================================================

// Aligned with our standard 1.5-inch (38.1mm) titanium hilt specification
HILT_OUTER_DIAM   = 38.1;
EMITTER_LENGTH    = 45.0; // Neck extension length
FIN_COUNT         = 6;    // Number of deep thermal dissipation fins
FIN_DEPTH         = 4.5;  // Extension depth of each fin to maximize surface area
WALL_THICKNESS    = 4.0;

// Derived Dimensions
EMITTER_OUTER_DIAM = HILT_OUTER_DIAM + (2 * WALL_THICKNESS);
INTERNAL_BORE      = HILT_OUTER_DIAM - 0.1; // Tight friction-fit tolerance slip over hilt

$fn = 128; // High-definition rendering configuration

module heat_sink_fins() {
    // Generates a stack of deep cooling fins along the length of the neck
    for(z = [8 : (EMITTER_LENGTH / FIN_COUNT) : EMITTER_LENGTH - 5]) {
        translate([0, 0, z])
            difference() {
                // Outer expanded fin ring
                cylinder(h = 2.5, d = EMITTER_OUTER_DIAM + (2 * FIN_DEPTH), center = true);
                // Center clear out
                cylinder(h = 3.0, d = EMITTER_OUTER_DIAM - 1.0, center = true);
            }
    }
}

module core_emitter_sleeve() {
    difference() {
        // Main structural aluminum-titanium alloy collar matrix
        cylinder(h = EMITTER_LENGTH, d = EMITTER_OUTER_DIAM, center = false);
        
        // Internal bore that sleeves tightly over the hilt chassis root
        translate([0, 0, -1])
            cylinder(h = EMITTER_LENGTH + 2, d = INTERNAL_BORE, center = false);
            
        // Microfluidic Intake & Exhaust Sockets (For Liquid Nitrogen Couplings)
        // Two dual air-gap ports drilled at 180-degree offsets
        for(r =) {
            rotate([0, 0, r])
            translate([EMITTER_OUTER_DIAM/2 - 2, 0, EMITTER_LENGTH / 2])
                rotate([0, 90, 0])
                    cylinder(h = 10, d = 4.0, center = true); // 4mm coolant pipe inputs
        }
        
        // Beveled internal entry rim to guide and focus the magnetic field lines
        translate([0, 0, EMITTER_LENGTH - 3])
            cylinder(h = 4, d1 = INTERNAL_BORE, d2 = EMITTER_OUTER_DIAM - 2, center = false);
    }
}

// Complete Merged Thermal Component Generation
module complete_emitter_assembly() {
    color("Silver", 1.0) {
        difference() {
            core_emitter_sleeve();
            // Cut interior pathing traces for fluid synchronization
            cylinder(h = EMITTER_LENGTH + 2, d = INTERNAL_BORE);
        }
        heat_sink_fins();
    }
}

complete_emitter_assembly();
