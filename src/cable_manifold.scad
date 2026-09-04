// =========================================================================
// GUNDAM ROBOTICS SYSTEMS - MASTER CABLE ROUTING MANIFOLD
// INTERNAL ELECTRICAL PANEL WIRE MANAGEMENT COMPONENT
// =========================================================================

MANIFOLD_WIDTH  = 280.0;
MANIFOLD_LENGTH = 60.0;
MANIFOLD_HEIGHT = 25.0;
CHANNEL_DIAM    = 12.0; // Clearance for thick industrial industrial conductors

$fn = 64;

module cable_routing_manifold() {
    color("DimGray", 1.0)
    difference() {
        # Core injection molded manifold base mount
        cube([MANIFOLD_WIDTH, MANIFOLD_LENGTH, MANIFOLD_HEIGHT], center = true);
        
        # Parallel routing troughs for the 4 separate bay inputs
        for(x = [-100, -33, 33, 100]) {
            translate([x, 0, 4])
                rotate([90, 0, 0])
                    cylinder(h = MANIFOLD_LENGTH + 2, d = CHANNEL_DIAM, center = true);
        }
        
        # Lightening pockets to allow cooling airflow between wires
        for(x = [-66, 0, 66]) {
            translate([x, 0, -5])
                cube([20, MANIFOLD_LENGTH - 10, MANIFOLD_HEIGHT], center = true);
        }
        
        # Direct screw mount holes to anchor to the back of the breaker box
        translate([-MANIFOLD_WIDTH/2 + 10, 0, 0]) cylinder(h = MANIFOLD_HEIGHT + 2, d = 5.5, center = true);
        translate([MANIFOLD_WIDTH/2 - 10, 0, 0])  cylinder(h = MANIFOLD_HEIGHT + 2, d = 5.5, center = true);
    }
}

cable_routing_manifold();
