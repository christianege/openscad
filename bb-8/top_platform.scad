
difference() {
    union() {
        cylinder(r=80/2,h=3,$fn=60);
        translate([0,0,2.99])cylinder(r2=20/2,r1=16,h=30,$fn=60);

        for(i=[120,240,360]) {
            rotate([0,0,i]) {
                translate([-2.5,0,2.99]) {
                    hull() {
                        translate([0,10,0])cube([5,30,0.01]);
                        translate([0,10,0])cube([5,0.01,30]);
                    }
                }
            }
        }
    }


    translate([0,0,3]) {
        #cylinder(r=12.3/2,h=50,$fn=100);
    }
    translate([0,0,-1])#cylinder(r=2/2,h=100);
    for(j=[60,180,300]) {
        rotate([0,0,j]) {
            translate([0,25,-1]) {
                #cylinder(r=3.5/2,h=100,$fn=60);
            }
            translate([0,25,1]) {
                #cylinder(r=6.4/2,h=100,$fn=6);
            }
        }
    }

}