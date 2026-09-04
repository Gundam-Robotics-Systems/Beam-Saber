// =========================================================================
// GUNDAM ROBOTICS SYSTEMS - BEAM-SABER BREAKAWAY DOCKING INTERFACE
// MECHANICAL SPECIFICATION FOR MULTI-BAY CHASSIS LATCH
// =========================================================================

// Standard parameters aligned with the 1.5-inch (38.1mm) titanium hilt shell
HILT_OUTER_DIAM = 38.1;
LATCH_LENGTH    = 60.0;
LATCH_WIDTH     = 50.0;
WALL_THICKNESS  = 4.0;

// Retention detent parameters for the physical breakaway action
DETENT_RADIUS   = 3.0;
DETENT_DEPTH    = 1.5;

$fn = 128;

module retention_dock_base() {
    // Heavy industrial carbon-filled nylon mounting block
    color("DimGray", 1.0)
    difference() {
        // Main block volume
        cube([LATCH_WIDTH, LATCH_LENGTH, HILT_OUTER_DIAM + 10], center = true);
        
        // Concentric cradle boring to receive the circular titanium hilt
        rotate([90, 0, 0])
            cylinder(h = LATCH_LENGTH + 2, d = HILT_OUTER_DIAM + 0.2, center = true);
            
        // Upper escape slot allowing the saber to be pulled out ("broken off") forward
        translate([0, 0, HILT_OUTER_DIAM/2])
            cube([HILT_OUTER_DIAM - 4, LATCH_LENGTH + 2, 20], center = true);
            
        // Recessed slots for 24K Gold spring-loaded contact pins (Charging Terminal)
        for(y = [-15, 15]) {
            translate([0, y, -HILT_OUTER_DIAM/2 - 2])
                cube([12, 6, 8], center = true);
        }
    }
}

module spring_loaded_detents() {
    // Mechanical ball-plunger detents that snap into the hilt grooves
    color("Gold", 1.0) {
        translate([-HILT_OUTER_DIAM/2, 0, 0])
            sphere(r = DETENT_RADIUS);
        translate([HILT_OUTER_DIAM/2, 0, 0])
            sphere(r = DETENT_RADIUS);
    }
}

// Composite Rendering of a Single Bay Dock Component
module complete_latch_bay() {
    difference() {
        retention_dock_base();
        // Cut clearances out for the ball plungers
        translate([-HILT_OUTER_DIAM/2, 0, 0]) cube([4,4,4], center=true);
        translate([HILT_OUTER_DIAM/2, 0, 0]) cube([4,4,4], center=true);
    }
    spring_loaded_detents();
}

complete_latch_bay();
