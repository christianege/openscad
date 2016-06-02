$fn=40;

module stand_arm_base() {
    hull() {
        cylinder(r=16/2, h=40);
        translate([30,0,0]) {
            cylinder(r=6/2, h=3);
        }
    }
}

module stand_arm() {
    difference() {
        stand_arm_base();
        translate([30,0,0]) {
            translate([0,0,-10]) {
                cylinder(r=3/2, h=20);
            }
            translate([0,0,3]) {
                cylinder(r=5/2, h=20);
            }            
        }
        translate([0,0,10]) {
            cylinder(r=11/2, h=50);
        }
    }
}
module stand() {
    for(i = [0,120,240]) {
        rotate([0,0,i]) {
            stand_arm();
        }
    }
}

difference() {
    stand();
    translate([0,0,0])rotate([0,90,60]) {
        cylinder(r=5/2, h=20);
    }
    sphere(r = 5/2);
}