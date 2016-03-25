height = (210-4)/2;

module slottedside(plug) {
    difference() {
        hull() {
            for(x = [0 : 20 : 20]) {
                for(y = [0 : 20 : 20]) {
                    translate([x,y,0]) {
                        cylinder(r=1,h=height, $fn=60);
                    }
                }
            }
        }
        translate([10-4.2/2,-1.1,-.1])cube([4.2,6,height+1]);
        translate([-1.1,10-4.2/2,-.1])cube([6,4.2,height+1]);
        if(false == plug) {
            translate([10,10,-0.1])cylinder(r=2.6,h=5,$fn=60);
            translate([3,3,-0.1])cylinder(r=2.2,h=5,$fn=60);
            translate([16,16,-0.1])cylinder(r=2.2,h=5,$fn=60);
            translate([3,16,-0.1])cylinder(r=2.2,h=5,$fn=60);
            translate([16,3,-0.1])cylinder(r=2.2,h=5,$fn=60);
            translate([16,16,-0.1])cylinder(r=2.2,h=5,$fn=60);
        }
    }

    translate([10,10,height-.1])cylinder(r=2.4,h=4.8,$fn=60);
    if(true == plug) {
        translate([3,3,height-.1])cylinder(r=2.0,h=4.8,$fn=60);
        translate([16,16,height-.1])cylinder(r=2.0,h=4.8,$fn=60);
        translate([3,16,height-.1])cylinder(r=2.0,h=4.8,$fn=60);
        translate([16,3,height-.1])cylinder(r=2.0,h=4.8,$fn=60);
        translate([16,16,height-.1])cylinder(r=2.0,h=4.8,$fn=60);
    }
}

translate([2,2,0]) rotate([0,0,0]) slottedside(plug=true);
translate([2,-2,0]) rotate([0,0,270]) slottedside(plug=true);
translate([-2,2,0]) rotate([0,0,90]) slottedside(plug=true);
translate([-2,-2,0]) rotate([0,0,180]) slottedside(plug=true);
