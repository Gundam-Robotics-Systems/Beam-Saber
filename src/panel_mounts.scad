// =========================================================================
// GUNDAM ROBOTICS SYSTEMS - INFRASTRUCTURE HARDWARE DESIGNS
// HEAVY STRUCTURAL REINFORCEMENT BRACKET FOR ELECTRICAL WALL PANELS
// =========================================================================

// Dimension alignment to match our 300x450mm master box chassis specs
BOX_WIDTH        = 300.0;
BRACKET_THICKNESS = 12.0;  // 12mm solid structural steel rating for breakaway loads
FLANGE_WIDTH      = 40.0;
MOUNT_HOLE_DIAM   = 8.5;   // Clearance holes for heavy M8 anchoring bolts

$fn = 64;

module industrial_support_strut() {
    color("SteelBlue", 1.0)
    difference() {
        // Main structural load-bearing backing bracket
        cube([BOX_WIDTH + (2 * FLANGE_WIDTH), 80.0, BRACKET_THICKNESS], center = true);
        
        // Master mounting slots to anchor into the wall studs/girders
        for(x = [-(BOX_WIDTH/2 + 20), (BOX_WIDTH/2 + 20)]) {
            translate([x, 0, 0])
                cylinder(h = BRACKET_THICKNESS + 2, d = MOUNT_HOLE_DIAM, center = true);
        }
        
        // Weight-reduction cutouts (Allows air circulation behind the panel backplane)
        for(x = [-100, 0, 100]) {
            translate([x, 0, 0])
                cube([45, 40, BRACKET_THICKNESS + 2], center = true);
        }
    }
}

module reinforced_alignment_tabs() {
    // Left and right vertical locking ears to capture the box shell sides
    color("DarkCyan", 1.0) {
        translate([-(BOX_WIDTH/2 + WALL_THICK), 0, 25])
            cube([6.0, 80.0, 50.0], center = true);
        translate([(BOX_WIDTH/2 + WALL_THICK), 0, 25])
            cube([6.0, 80.0, 50.0], center = true);
    }
}

// Unified Structural Support Unit Execution
module complete_mounting_hardware() {
    industrial_support_strut();
    // Interlock vertical gussets onto the support anchor plates
    difference() {
        reinforced_alignment_tabs();
        // Clear fastener passthroughs for panel securing bolts
        for(x = [-(BOX_WIDTH/2 + WALL_THICK), (BOX_WIDTH/2 + WALL_THICK)]) {
            translate([x, 0, 25])
                rotate([0, 90, 0])
                    cylinder(h = 20, d = 6.5, center = true);
        }
    }
}

complete_mounting_hardware();
