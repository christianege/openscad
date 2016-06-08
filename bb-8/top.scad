
difference() {
    hull() {
    cylinder(r=80/2,h=1,$fn=60);
    translate([-25,0,15]) rotate([0,90,0])cylinder(r=0.1,h=50);
    }
    for(j=[60,180,300]) {
        rotate([0,0,j]) {
            translate([0,25,-1]) {
                #cylinder(r=3.2/2,h=100,$fn=60);
            }
            translate([0,25,3]) {
                #cylinder(r=6/2,h=100,$fn=60);
            }
        }
    }
}