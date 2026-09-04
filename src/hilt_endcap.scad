// =========================================================================
// GUNDAM ROBOTICS SYSTEMS - BEAM-SABER SOLID-STATE ENDCAP
// HOUSING FOR QUANTUM POWER RECEPTION MANIFOLD (NO BATTERY RETAINER)
// =========================================================================

HILT_OUTER_DIAM   = 38.1;
ENDCAP_LENGTH     = 25.0; 
WALL_THICKNESS    = 6.0;  // Heavy base shielding for quantum termination

INTERNAL_BORE      = HILT_OUTER_DIAM - (2 * WALL_THICKNESS);

$fn = 128;

module solid_state_endcap() {
    color("LightGray", 1.0)
    difference() {
        // Main structural base cap
        cylinder(h = ENDCAP_LENGTH, d = HILT_OUTER_DIAM, center = false);
        
        // Internal cavity for the non-contact Quantum Receiver Terminal
        translate([0, 0, WALL_THICKNESS])
            cylinder(h = ENDCAP_LENGTH, d = INTERNAL_BORE, center = false);
            
        // Fine metric threads machined to lock directly to the lower titanium shell
        translate([0, 0, ENDCAP_LENGTH - 4])
            cylinder(h = 5, d = HILT_OUTER_DIAM - 1.0, center = false);
            
        // Photonic line viewport for real-time laser initialization checks
        translate([0, 0, -1])
            cylinder(h = WALL_THICKNESS + 2, d = 4.0, center = false);
    }
}

solid_state_endcap();
