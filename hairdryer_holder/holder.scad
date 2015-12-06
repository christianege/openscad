// Holder for wine bottles
// License GNU AFFERO GENERAL PUBLIC LICENSE v3+
// Copyright 2015 Christian Ege

holder_x = 22;
holder_y = 115;
holder_z = 19;

dia_peg = 8;

peg_pos = [ [0,7+dia_peg/2,holder_z-0.1],
            [0,79+dia_peg/2,holder_z-0.1]
];

mounting_pos = [[0,70,(holder_z/2)-0.9],[0,105,(holder_z/2)-0.9]];
mounting_dia = 5;

conus_top = 9.8/2;
conus_bottom = 3.8/2;
conus_h = 4;
//2.25;

module base() {
    
    translate([-holder_x/2,0,0]) {
        cube([holder_x,holder_y,holder_z]);
    }
    for(pos=peg_pos) {
        translate(pos) {
            cylinder(r=dia_peg/2,h=1,$fn=100);
        }
    }
}

module drill_holes() {
    for(pos=peg_pos) {
        translate([pos[0],pos[1],(pos[2]-10)+1.1]) {
            cylinder(r=2.8/2,h=10,$fn=100);
        }
    }
}

module abudment() {
    $fn=60;
    difference() {
        cylinder(h=3,r=14/2);
        translate([0,0,-1])#cylinder(h=5,r=3.2/2);
        translate([0,0,3-1])#cylinder(h=1.5,r=6/2);
        translate([-7,(14/2)-2.25,0])rotate([0,90,0])#cylinder(h=14,r=1.8/2);
    }
}

module mounting() {
    $fn=60;
    for(pos=mounting_pos) {
        translate([pos[0],pos[1],pos[2]+(holder_z/2+1)-conus_h]){
            cylinder(r2=conus_top,r1=conus_bottom,h=conus_h);
        }
        translate(pos){
            cylinder(h=holder_z+2,r=mounting_dia/2,center=true);
        }
    }
}

difference() {
    base();
    drill_holes();
    mounting();
}

translate([30,0,0])abudment();
translate([30,30,0])abudment();