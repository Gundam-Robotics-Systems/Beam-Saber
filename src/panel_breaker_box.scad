// =========================================================================
// GUNDAM ROBOTICS SYSTEMS - INDUSTRIAL BREAKER BOX ENCLOSURE
// WALL-MOUNTED INTERFACE FOR AUTO-RESTORING BEAM-SABER MAIN POWER
// =========================================================================

// Global Dimensions in Millimeters
BOX_WIDTH  = 300.0;
BOX_LENGTH = 450.0;
BOX_HEIGHT = 150.0;
WALL_THICK = 5.0; // Thick structural shielding

$fn = 64;

module main_panel_housing() {
    // Durable industrial carbon steel chassis frame
    color("DarkSlateGray", 0.9)
    difference() {
        // Core outer bounding volume
        cube([BOX_WIDTH, BOX_LENGTH, BOX_HEIGHT], center = true);
        
        // Hollow interior for routing boards and high-voltage switches
        cube([BOX_WIDTH - (2*WALL_THICK), BOX_LENGTH - (2*WALL_THICK), BOX_HEIGHT - WALL_THICK], center = true);
        
        // Heat Sink Ventilation Grills (Prevents air stagnation from optocouplers)
        for(y = [-150 : 30 : 150]) {
            translate([BOX_WIDTH/2 - 2, y, 20])
                cube([10, 15, 40], center = true);
        }
        
        // Main Conduit Knockout Outlets (For 480V direct line-feed input wires)
        translate([0, -BOX_LENGTH/2, -20])
            rotate([90, 0, 0])
                cylinder(h = 20, d = 40, center = true);
    }
}

module auto_restoring_breaker_switches() {
    // Three separate heavy-duty physical switch arrays for line protection
    color("Red", 1.0) {
        for(y = [-80, 0, 80]) {
            translate([-40, y, BOX_HEIGHT/2 - 2])
                cube([25, 40, 20], center = true);
        }
    }
}

module charging_cradle_interface_terminal() {
    // Heavily insulated terminal port to link the hilt's snap-circuit connector
    color("Black", 1.0)
    translate([60, -100, BOX_HEIGHT/2 - 5]) {
        difference() {
            cube([70, 120, 20], center = true);
            // Concave docking pocket for secure terminal locking
            cube([60, 110, 25], center = true);
        }
    }
}

// Composite Model Assembly Generation
module generate_complete_panel() {
    main_panel_housing();
    auto_restoring_breaker_switches();
    charging_cradle_interface_terminal();
}

generate_complete_panel();
