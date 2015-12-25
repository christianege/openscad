


module cover() {
    translate([0,0,+(5/2)+5*3])difference() {
        cube([120,120,5],center=true);
        for(x = [-30 : 20 : 30]) {
            for(y = [-30 : 20 : 30]) {
                translate([x,y,-5.2/2])#cylinder(r=5/2,h=10,$fn=60);
            }
        }
    }
}

module connection() {
    {
        translate([0,0,(5/2)]) {
            difference() {
            cube([120,120,5],center=true);
            translate([0,0,-0.1])cube([80,80,5.3],center=true);
            for(y = [-50 : 100 : 50]) {
                for(x = [-30 : 20 : 30]) {
                    translate([x,y,-5.1/2])#cylinder(r=3/2,h=6,$fn=60);
                    translate([y,x,-5.1/2])#cylinder(r=3/2,h=6,$fn=60);
                }
            }
        }
    }
    }
}

module back() {
    translate([0,0,(5/2)]) cube([120,120,5],center=true);
}

//cover();
//connection();
//back();

